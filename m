Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285481AbRLSU2b>; Wed, 19 Dec 2001 15:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285496AbRLSU20>; Wed, 19 Dec 2001 15:28:26 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:17305 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S285481AbRLSU05>; Wed, 19 Dec 2001 15:26:57 -0500
Message-ID: <3C206BEF.95F7E905@earthlink.net>
Date: Wed, 19 Dec 2001 05:29:03 -0500
From: Jeff <piercejhsd009@earthlink.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA sound and SNDCTL_DSP_NONBLOCK error.....
In-Reply-To: <3C1EEDFF.231F36B8@earthlink.net> <3C1F7E9D.DED578C7@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, upgrading from 1.4.x version supplied with Slackware 8.0 to
the latest version 1.9.1 solved the SNDCTL_DSP_NONBLOCK problem.
The new problem is now

      val = 0;  // no input sigs get to output
      if (ioctl(mixer_fd, MIXER_WRITE(SOUND_MIXER_OUTSRC), &val) < 0)
      {
         fprintf (stderr, "mixer outsrc failed\n");

Failing, all the other of the many ioctl calls work ok. 

p.s sorry about saying suse, weak memory :-).
 
Jeff Garzik wrote:
> 
> Jeff wrote:
> >
> > I am a ham radio operator who wishes to use the sound card for digital
> > comunications. However, my system has the VIA 82c686/ac97 sound. While I
> > can ofcourse make the sound work, playing/recording,etc, I cannot use it
> > with ham software.
> > Take twpsk31 for example, it compiles, but when trying to run it stops
> > on:
> > SNDCTL_DSP_NONBLOCK: illegal parameter.
> 
> update the software to use normal fcntl(2)
> 
> --
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno

jeff
piercejhsd009@earthlink.net
