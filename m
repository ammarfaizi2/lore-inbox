Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbTDPEYE (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 00:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264225AbTDPEYE 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 00:24:04 -0400
Received: from haw-66-102-130-200.vel.net ([66.102.130.200]:32197 "HELO
	mx100.mysite4now.com") by vger.kernel.org with SMTP id S264223AbTDPEYD 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 00:24:03 -0400
From: Udo Hoerhold <maillists@goodontoast.com>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: SoundBlaster Live! with kernel 2.5.x
Date: Wed, 16 Apr 2003 00:34:11 -0400
User-Agent: KMail/1.5.1
References: <200304152001.35975.maillists@goodontoast.com> <1050457791.3664.188.camel@localhost> <200304152228.11010.maillists@goodontoast.com>
In-Reply-To: <200304152228.11010.maillists@goodontoast.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304160034.11567.maillists@goodontoast.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 April 2003 09:49 pm, Robert Love wrote:
> On Tue, 2003-04-15 at 20:01, Udo Hoerhold wrote:
> > I've been running Debian woody with 2.4.20 kernel.  I'm trying to
> > switch to 2.5.  I built 2.5.67 with emu10k driver in the kernel (same
> > as I had with 2.4.20), but I get only a lot of popping sounds from the
> > sound card. I also tried 2.5.50 and 2.5.67-mm3, with the same result. 
> > I googled for emu10k and soundblaster with 2.5, but I haven't seen
> > anyone else with the same problem. Does anyone know what this problem
> > is?
>
> Not sure.  It seems to work fine here.
>
> Are you using ALSA or OSS?  Best bet is ALSA.  You want something like:
>
>         CONFIG_SND=y
>         CONFIG_SND_SEQUENCER=y
>         CONFIG_SND_OSSEMUL=y
>         CONFIG_SND_MIXER_OSS=y
>         CONFIG_SND_PCM_OSS=y
>         CONFIG_SND_SEQUENCER_OSS=y
>         CONFIG_SND_EMU10K1=y
>
> And then do not include any of the OSS stuff.
>
> Then a normal audio playback on /dev/audio or whatever should work fine.
>
> If not, do you see any errors during boot?
>
> 	Robert Love

I have the exact configuration you have above.  The soundcard is detected,
but I do get one error:

Apr 15 22:17:45 hobbiton kernel: Advanced Linux Sound Architecture Driver
Version 0.9.2 (Thu Mar 20$
Apr 15 22:17:45 hobbiton kernel: request_module: failed /sbin/modprobe --
snd-card-0. error = -16
Apr 15 22:17:45 hobbiton kernel: PCI: Found IRQ 10 for device 02:0b.0
Apr 15 22:17:45 hobbiton kernel: PCI: Sharing IRQ 10 with 00:1f.2
Apr 15 22:17:45 hobbiton kernel: ALSA device list:
Apr 15 22:17:45 hobbiton kernel:   #0: Sound Blaster Live! (rev.7) at
0xdf80, irq 10

I've been ignoring modprobe errors because I know there are some issues
with 2.5 kernel and modules, and I'm compiling everything into the kernel. 
Could this be causing a problem, though?

Thanks,

Udo Hoerhold

