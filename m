Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423277AbWJYLZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423277AbWJYLZX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 07:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423281AbWJYLZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 07:25:23 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:31238 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1423277AbWJYLZW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 07:25:22 -0400
Date: Wed, 25 Oct 2006 13:25:34 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Auke Kok <auke-jan.h.kok@intel.com>, Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: Linux 2.6.19-rc3
Message-Id: <20061025132534.df8466c0.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006 16:22:59 -0700 (PDT), Linus Torvalds wrote:
> 
> Ok,
>  a few days late, because I'm a retard and didn't think of doing a release 
> when I should have. 
> 
> I'm also a bit grumpy, because I think people are sending me more stuff 
> than they should at this stage in the game. We've been pretty good about 
> keeping the later -rc releases quiet, please keep it that way.
> 
> That said, it's mostly harmless cleanups and some architecture updates. 
> And some of the added warnings about unused return values have caused a 
> number of people to add error handling. And on the driver front, there's 
> mainly new driver ID's, and a couple of new drivers.
> 
> Shortlog appended,
> (...)
> Auke Kok (1):
>       e100: fix reboot -f with netconsole enabled

This one breaks power-off and reboot on my laptop (thanks to git
bisect for isolating it). The shutdown freezes after "Shutdown: hda" or
"Rebooting". SysRq-p says the CPU is idle. If you need additional
information on my config or want me to do more tests, just ask.

Adrian, you can add this to your list of known regressions.

Thanks,
-- 
Jean Delvare
