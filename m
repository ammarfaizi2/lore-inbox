Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWD2Oap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWD2Oap (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 10:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWD2Oap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 10:30:45 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:38665 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750706AbWD2Oap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 10:30:45 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: make O="<dir>" install; output not relocated; 2.6.16.11(kbuild)
Date: Sat, 29 Apr 2006 15:30:54 +0100
User-Agent: KMail/1.9.1
Cc: Linda Walsh <lkml@tlinx.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
References: <4451B77D.7070000@tlinx.org> <44524A3F.6060203@tlinx.org> <20060429070806.GK25520@lug-owl.de>
In-Reply-To: <20060429070806.GK25520@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604291530.54658.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 April 2006 08:08, Jan-Benedict Glaw wrote:
[snip]
> >    Fair enough, but I'm more interested in where to specify
> > the target location of the installed kernel and System.map as
> > I don't always have modules for a generated kernel, but usually
> > (near 100% :-)) have an installable kernel image.  For development,
> > I could see it being useful to mount the target system's root in
> > a local directory (like /mnt), then have the kernel build install
> > to a target root of "/mnt".
>
> Installing the kernel image is quite architecture specific; most
> architectures use $(INSTALL_PATH), so this could be something like
> /path/to/target_system/boot .  Though they may also re-run lilo or
> something like that, so it's possibly not what you actually want to
> use.

I'm fairly sure modern 2.6 kernels do the following with "make install":

1)	Try to run ~/bin/installkernel script.
2)	Try to run /sbin/installkernel (distributions)
3)	Guess an install path and run LILO.

If you hack together an "installkernel" I'm sure you could get it to do what 
you want. It certainly works here (I have it generate a menu.lst update for 
grub and copy my images to /boot/vmlinuz-version 
and /boot/System.map-version, and run make modules_install).

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
