Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268565AbUJJXZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268565AbUJJXZt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 19:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268568AbUJJXZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 19:25:49 -0400
Received: from smtp07.auna.com ([62.81.186.17]:38875 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S268565AbUJJXZr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 19:25:47 -0400
Date: Sun, 10 Oct 2004 23:25:46 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: udev: what's up with old /dev ?
To: Hacksaw <hacksaw@hacksaw.org>
Cc: linux-kernel@vger.kernel.org
References: <200410102315.i9ANF7OI019460@hacksaw.org>
In-Reply-To: <200410102315.i9ANF7OI019460@hacksaw.org> (from
	hacksaw@hacksaw.org on Mon Oct 11 01:15:07 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1097450746l.5993l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.11, Hacksaw wrote:
> >The very first thing init does is open /dev/console, and if it doesn't
> >exist the entire boot hangs.
> 
> This raises a question: Would it be a useful thing to make a modified init 
> that could run udev before it does anything else?

I don't think it is needed. There is no problem (i am thinking on rootles
nodes and PXE and so on...) on building a simple initrd with /dev/console,
/dev/null and half a dozen standard devices if they are needed. Just
to get udev run and have your real devices mounted there and overwrite
them.

I just remember one other oddity. To clean up my system, I copied the
running /dev to /dev-new, moved /dev to /dev-old and /dev-new to /dev.
But on 'reboot', I got a complaint about /dev/initctl not opening.
This could happen also with init. It opens real /dev/initctl on boot,
mounts /dev and tries to use new /dev/inittclt on shutdown...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc3-mm3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #2


