Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbRGJWnt>; Tue, 10 Jul 2001 18:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbRGJWnj>; Tue, 10 Jul 2001 18:43:39 -0400
Received: from oe71.law11.hotmail.com ([64.4.16.206]:18188 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267101AbRGJWn2>;
	Tue, 10 Jul 2001 18:43:28 -0400
X-Originating-IP: [208.181.16.29]
From: "David Grant" <davidgrant79@hotmail.com>
To: <antoniopagliaro@tin.it>, <linux-kernel@vger.kernel.org>
In-Reply-To: <01071023392004.02550@lila.localdomain>
Subject: Re: Athlon Thunderbird, Abit KT7 Raid, Kernel 2.4: DESKTOP FROZEN!
Date: Tue, 10 Jul 2001 15:47:53 -0700
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <OE71fNIJWNDIT6bB5Rw000088d3@hotmail.com>
X-OriginalArrivalTime: 10 Jul 2001 22:43:23.0914 (UTC) FILETIME=[BA08EEA0:01C10991]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had almost identical problems using Redhat 7.1 (2.4.2-2 kernel) on
Athlon 1.2 GHz Asus A7V133 with the VIA on-board IDE (686b).

Try switching to the other on-board IDE controller, should be HTP370 IDE.
It's probably the VIA southbridge that's causing you these troubles.  I
upgraded my kernel to 2.4.5 and 2.4.6 and nothing helped for me (I have a
686b, you have a 686a).  The only thing I could do was switch to my on-board
Promise IDE controller.  I have no idea what the HTP370 is, but I'm guessing
it won't cause you problems like the VIA will.

You could try compiling a new kernel 2.4.5 or 2.4.6.  There were many IDE
fixes between 2.4.2 and 2.4.6.  Especially with the VIA stuff I think,
thanks to Vojtech Pavlick.  However, I never got my VIA controller to work.
Even if I disabled all DMA it still crashed the kernel every time.

David Grant

----- Original Message -----
From: "Antonio Pagliaro" <antoniopagliaro@tin.it>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, July 10, 2001 2:39 PM
Subject: Athlon Thunderbird, Abit KT7 Raid, Kernel 2.4: DESKTOP FROZEN!


>
> My box: Athlon Thunderbird 900 MHz, MotherboardAbit KT7 Raid,
> Kernel 2.4 (the one that comes with Red Hat 7.1 no updates)
>
> I get apparently random desktop freezing.
>
> Last time:
>
> I was just doing nothing so the screensaver
> was on when I noticed the screen was frozen. Nor the keyboard
> neither the mouse worked. No combination of CTRL-ALT keys.
> Only choice left: reset. I did it.  When it booted again I got a
>
> Kernel Panic: Attempted to kill the idle task
> In idle: not syncing.
>
> (by the way: what is the SysRq magic or something similar?
> Does it help? Which keys??)
>
> This time I had to unplug the computer. After 5 minutes I tried again.
> In many trials I got hundreds of errors. These:
>
> -After checking /root (passed), it stopped checking /home (failed)
> and trying to repair it with fsck gave no result (when the computer
> tried to reboot, it freezes again)
>
> -After checking both /root and /home (passed), it stopped at sshd
> saying: /etc/rc.d/rc line 117 951 segmentation fault  $i start
>
> -At the end of the startup, black screen and message:
> Id "x" respawning too fast disabled for 5 minutes (and waiting
> produces the same message again: I had to unplug)
>
> -Inside KDE, trying to open anything gave an error related to
> inode and in a few seconds X was disabled again for 5 minutes.
>
> Since somebody tells me the Oops is important, I noticed that
> when this appeared it was 0002. If this helps..
>
> After a couple of hours I tried and I was succesfull. Now it seems
> to be everything ok.
>
> Anyway, a desktop freezing happens every now and again and
> no ctrl-alt-anything combination works. Just reset.
> This is very dangerous, and even if so far the fsck was always ok,
> I feel my data are at high risk this way.
>
> At Red Hat support I got this suggestion:
> >Since you are using KDE, there has been a few bugs in terms of memory
hole
> >that
> >have been fixed.  You can check them out and apply the updtes to your
> >machine
> >and we'll see if that could the problem.
> >
> >http://www.redhat.com/support/errata/RHSA-2001-059.html
>
> Is this really a KDE problem? I myself doubt...
> It could be a kernel problem or maybe hardware (I checked
> all the ram and removed one, but freezing is still there)
>
> Thanks for any help, I am in trouble!!
>
> Antonio
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
