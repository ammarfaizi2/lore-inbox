Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130418AbRBHVwP>; Thu, 8 Feb 2001 16:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131277AbRBHVwG>; Thu, 8 Feb 2001 16:52:06 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:42914 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S130418AbRBHVvv>;
	Thu, 8 Feb 2001 16:51:51 -0500
Message-ID: <3A831583.DB42650B@itwm.fhg.de>
Date: Thu, 08 Feb 2001 22:54:11 +0100
From: Martin Braun <braun@itwm.fhg.de>
Organization: ITWM e. V.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Martin Braun <braun@itwm.fhg.de>, linux-kernel@vger.kernel.org
Subject: Re: No sound on GA-7ZX (2.4.1-ac6, via audio)
In-Reply-To: <3A82F427.916F8F0C@itwm.fhg.de> <3A82F9BF.5A680E37@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Martin Braun wrote:
> > I can not get sound working on a computer with a Gigabyte
> > GA-7ZX mainboard (KT133 chipset). Is this a known problem?
> > I have attached some config info. Mail me for further details.
> 
> > $ cat /proc/driver/via/0/*
> > Vendor name      : SigmaTel STAC????
> > Vendor id        : 8384 7600
> 
> 1) Have you turned the master volume and PCM volume -way- up?

Yes.

There is some noise when I send an audio file directly to the device,
i. e. cat error.wav > /dev/dsp. However, all sound programs I have
tried fail to set the audio speed (RedHat 7, tried sox, xmms, mpg123).
Sample strace output (mpg123):
...
alarm(10)                               = 0
pause()                                 = ? ERESTARTNOHAND (To be
restarted)
--- SIGALRM (Alarm clock) ---
sigreturn()                             = ? (mask now [])
alarm(0)                                = 10
rt_sigaction(SIGUSR1, {SIG_DFL}, NULL, 8) = 0
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
open("/dev/dsp", O_WRONLY|O_NONBLOCK)   = 4
fcntl64(4, F_GETFL)                     = 0x801 (flags
O_WRONLY|O_NONBLOCK)
fcntl64(4, F_SETFL, O_WRONLY)           = 0
ioctl(4, SNDCTL_DSP_SETFRAGMENT, 0xbffff7e0) = 0
ioctl(4, SNDCTL_DSP_SETFMT, 0xbffff7e0) = 0
ioctl(4, SNDCTL_DSP_GETFMTS, 0xbffff7e0) = 0
ioctl(4, SNDCTL_DSP_STEREO, 0xbffff7e0) = 0
ioctl(4, SNDCTL_DSP_SPEED, 0xbffff7e0)  = 0
write(2, "unsupported playback rate: 22050"..., 33) = 33
close(4)                                = 0
write(2, "audio: Interrupted system call\n", 31) = 31
_exit(1)                                = ?
(END)      
> 
> 2) Does 2.4.1-ac5 work for you?  (ie. did 2.4.1-ac6 break something?)
> 

I only tried 2.4.1 without patches on this machine which did not work
either. 

Martin Braun

>         Jeff
> 
> --
> Jeff Garzik       | "You see, in this world there's two kinds of
> Building 1024     |  people, my friend: Those with loaded guns
> MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
