Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284073AbRLWTjt>; Sun, 23 Dec 2001 14:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284117AbRLWTjk>; Sun, 23 Dec 2001 14:39:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26968 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S284073AbRLWTj2>; Sun, 23 Dec 2001 14:39:28 -0500
To: Andreas Gietl <a.gietl@e-admin.de>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: serial console on > 2.4.14
In-Reply-To: <E16I9Fq-0007yj-00@d101.x-mailer.de>
	<20011223142331.A27993@flint.arm.linux.org.uk>
	<E16I9fm-0001wk-00@d101.x-mailer.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Dec 2001 12:37:43 -0700
In-Reply-To: <E16I9fm-0001wk-00@d101.x-mailer.de>
Message-ID: <m1lmftram0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gietl <a.gietl@e-admin.de> writes:

> On Sunday 23 December 2001 15:23, Russell King wrote:
> 
> This is what stty gives 
> 
> speed 38400 baud; rows 0; columns 0; line = 0;
> intr = ^C; quit = ^\; erase = ^?; kill = ^X; eof = ^D; eol = <undefiniert>; 
> eol2 = <undefiniert>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = 
> ^W; lnext = ^V;
> flush = ^O; min = 1; time = 0;
> -parenb -parodd cs8 hupcl -cstopb cread -clocal -crtscts
> -ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl -ixon 
> -ixoff -iuclc -ixany -imaxbel
> -opost -olcuc -ocrnl -onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 
> ff0
> -isig -icanon -iexten -echo -echoe -echok -echonl -noflsh -xcase -tostop 
> -echoprt -echoctl -echoke
> 
> 
> 
> But if forgot to say that after the startup completed and agetty starts the 
> console the input works again. It just does not work during the startup. It 
> works before the startup to go into the bios and it works after the startup.

You almost certainly have an init that is clearing cread.  There are patched
versions that have this problem fixed.  Apparently cread actually being implemented
in the kernel serial drivers is new, and only started appearing since 2.4.2.

Eric
