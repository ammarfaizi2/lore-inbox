Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283267AbRLWOfH>; Sun, 23 Dec 2001 09:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbRLWOe5>; Sun, 23 Dec 2001 09:34:57 -0500
Received: from d101.x-mailer.de ([212.162.12.2]:30872 "EHLO d101.x-mailer.de")
	by vger.kernel.org with ESMTP id <S283267AbRLWOeq>;
	Sun, 23 Dec 2001 09:34:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gietl <a.gietl@e-admin.de>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: serial console on > 2.4.14
Date: Sun, 23 Dec 2001 15:33:45 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16I9Fq-0007yj-00@d101.x-mailer.de> <20011223142331.A27993@flint.arm.linux.org.uk>
In-Reply-To: <20011223142331.A27993@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16I9fm-0001wk-00@d101.x-mailer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 December 2001 15:23, Russell King wrote:

This is what stty gives 

speed 38400 baud; rows 0; columns 0; line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^X; eof = ^D; eol = <undefiniert>; 
eol2 = <undefiniert>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = 
^W; lnext = ^V;
flush = ^O; min = 1; time = 0;
-parenb -parodd cs8 hupcl -cstopb cread -clocal -crtscts
-ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl -ixon 
-ixoff -iuclc -ixany -imaxbel
-opost -olcuc -ocrnl -onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 
ff0
-isig -icanon -iexten -echo -echoe -echok -echonl -noflsh -xcase -tostop 
-echoprt -echoctl -echoke



But if forgot to say that after the startup completed and agetty starts the 
console the input works again. It just does not work during the startup. It 
works before the startup to go into the bios and it works after the startup.


> On Sun, Dec 23, 2001 at 03:06:58PM +0100, Andreas Gietl wrote:
> > I compiled all kernels with the same configuration with serial
> > console-option enabled. With 2.4.14 everything is just fine: I see the
> > kernel-output and can type in things during startup esp. do a fsck. With
> > 2.4.16 and 2.4.17 i SEE everything but no input is accepted.
>
> From what I've deduced, there are a number of SysVinit implementations out
> there that incorrectly clear the terminals CREAD flag.
>
>        [-]cread
>               allow input to be received
>
> Obviously if it is cleared, then you'll see your behaviour.  If you can log
> into the box some other way, please check the settings using:
>
> 	stty -aF /dev/ttyS0

-- 
e-admin internet gmbh
Andreas Gietl
Roter-Brach-Weg 124a
tel +49 941 3810884
fax +49 941 3810891
mobil +49 171 6070008
