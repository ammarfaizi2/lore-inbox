Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUFYM2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUFYM2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUFYM2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:28:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:19080 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265874AbUFYM07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:26:59 -0400
Date: Fri, 25 Jun 2004 08:26:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: David van Hoose <david.vanhoose@comcast.net>
cc: Christoph Hellwig <hch@infradead.org>,
       Helge Hafting <helge.hafting@hist.no>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
In-Reply-To: <40DC1192.7030006@comcast.net>
Message-ID: <Pine.LNX.4.53.0406250819040.28070@chaos>
References: <40DB605D.6000409@comcast.net> <40DBED77.6090704@hist.no>
 <40DC0CE0.6040509@comcast.net> <20040625114105.GA28892@infradead.org>
 <40DC1192.7030006@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004, David van Hoose wrote:

> yeah.. Really. Here's what I do.
>
> I have ext3 partitions, so I decided if they are different partitions,
> then I can compile my kernel with ext2 as a module and ext3 builtin.
> So I do it and reboot. Panic! Reason? Cannot find filesystem for the
> root partition.
> The error is in the kernel itself either way. Pick your reason.
> 1) ext3 is identified as ext2 on bootup.
> 2) There is no fallback to ext3 if ext2 is not found.
>
> I'll check this again to be sure on a 2.6 kernel later today, but as far
> as 2.4 is concerned my kernel panics.
>
> Regards,
> David
>
> PS. Shut up with the cheap insults. I have empirical evidence supporting
> my claim. Meaning there exists a bug somewhere.

If you make the root file-system, or any part of it, a module, then
the module must be loaded before the kernel attempts to mount the
root file-system. This is normally done using `initrd`. You need to
find out how to reconfigure `initrd` to handle your changes. This
varies between vendors and has nothing to do with the kernel. In
fact, when you see the message about being unable to mount the root
file-system, it means that the kernel was running fine but ran out
of things to do on startup because somebody, probably you, failed to
provide an available file-system to mount so it could continue the
startup by executing `init`.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


