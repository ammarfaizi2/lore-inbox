Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290713AbSCOLDx>; Fri, 15 Mar 2002 06:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSCOLDr>; Fri, 15 Mar 2002 06:03:47 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11650 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S290593AbSCOLDH>;
	Fri, 15 Mar 2002 06:03:07 -0500
Date: Thu, 14 Mar 2002 15:12:00 +0000
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, andersen@codepoet.org,
        Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020314151200.C37@toy.ucw.cz>
In-Reply-To: <3C8D5ECD.6090108@mandrakesoft.com> <Pine.LNX.4.33.0203111810220.8121-100000@home.transmeta.com> <20020312073204.B4863@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020312073204.B4863@ucw.cz>; from vojtech@suse.cz on Tue, Mar 12, 2002 at 07:32:04AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Well, there are uses for the 'dynamic' filter, and it doesn't add too
> much complexity. One could be allowing certain commands to be performed
> on certain devices by normal users - eg. CD-burning or whatever without

That should be better done userspace: setuid on cdrecord + its security audit
seems like nice solution.

> root privileges (I know we're using ide-scsi for the command access
> right now ...), and also protecting the oneself from ACPI and the like.
> Because ACPI can do IDE commands and does that in a way interfaceable to
> a 'taskfile' kernel ioctl. It'd be nice to know a broken ACPI
> implementation can't screw up your drive easily through a kernel driver.

This is entirely different can of worms, and should be easy to do at ACPI
level.
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

