Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262485AbRFHEil>; Fri, 8 Jun 2001 00:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262550AbRFHEib>; Fri, 8 Jun 2001 00:38:31 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:54685 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S262485AbRFHEiU>; Fri, 8 Jun 2001 00:38:20 -0400
Message-ID: <3B2056DC.EBC00D80@idcomm.com>
Date: Thu, 07 Jun 2001 22:38:52 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: missing sysrq
In-Reply-To: <Pine.LNX.4.33.0106072239570.26171-100000@asdf.capslock.lan>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mike A. Harris" wrote:
> 
> On Fri, 1 Jun 2001, Dieter Nützel wrote:
> 
> >> > In article <3B15EF16.89B18D@idcomm.com> you wrote:
> >> > > However, if I go to /proc/sys/kernel/sysrq does not exist.
> >> >
> >> > It is a compile time option, so the person who compiled your kernel
> >> > left it out.
> >>
> >> I compiled it, and the sysrq is definitely in the config. No doubt at
> >> all. I also use make mrproper and config again before dep and actual
> >> compile. Maybe it is just a quirk/oddball.
> >>
> >> D. Stimits, stimits@idcomm.com
> >
> >Have you tried "echo 1 > /proc/sys/kernel/sysrq"?
> >You need both, compiled in and activation.

Since then I've completely removed that kernel source and kernel, only
the config file remains (and it had it activated if the config followed
it). All kernels before worked, and those since then also work, so I
know it isn't the keyboard. I also always run make mrproper and config
it again between compiles (I keep a list of config history), so I don't
know what was wrong, but replacing the kernel fixed it, and is no longer
an issue. I will, however, keep the showkey suggestion handy in case it
ever does it again.

D. Stimits, stimits@idcomm.com

> 
> If you *know* it is compiled into your kernel, and you *know* it
> is enabled via the above, and it still does not work, do the
> following:
> 
> Run:
> 
> showkey -s
> 
> Then press LALT quickly followed by SYSRQ, and keep holding both
> down, and you should see:
> 
> 0x38
> 0x54
> 
> You might see a bunch of extra 0x38's which is ok.
> 
> If however when you press ALT-SYSRQ you see:
> 
> 0x38 0x54 0xd4
> 
> and are still holding both keys down, then your keyboard is
> broken and incompatible with the kernel SYSRQ feature.
> 
> A proper keyboard will only show "0x38 0x54".  I have written a
> patch for SYSRQ to allow it to be used with broken keyboards that
> send the make+break code for the SYSRQ sequence simultaneously.
> 
> If you need it, let me know and I'll send it to you.
> 
> ----------------------------------------------------------------------
>     Mike A. Harris  -  Linux advocate  -  Open Source advocate
>        Opinions and viewpoints expressed are solely my own.
> ----------------------------------------------------------------------
