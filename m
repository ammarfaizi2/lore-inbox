Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbWAKBoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWAKBoc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbWAKBoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:44:32 -0500
Received: from adsl-69-154-123-204.dsl.fyvlar.swbell.net ([69.154.123.204]:3254
	"EHLO electronsrus.com") by vger.kernel.org with ESMTP
	id S1161054AbWAKBob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:44:31 -0500
From: Fredrick O Jackson <fred@electronsrus.com>
To: linux-kernel@vger.kernel.org
Subject: Re: soundblaster pnp ide won't pnp
Date: Tue, 10 Jan 2006 19:44:03 -0600
User-Agent: KMail/1.8.3
Cc: Lee Revell <rlrevell@joe-job.com>,
       ALSA user list <alsa-user@lists.sourceforge.net>
References: <200601101916.28019@bits.electronsrus.com> <1136942735.2007.120.camel@mindpipe>
In-Reply-To: <1136942735.2007.120.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101944.03724@bits.electronsrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually, I have no interest in the sound card except for the ide port. In at 
least one configuration, "modprobe sb" didn't produce errors, and that was 
without any hassling with pnp. Just for kicks, I just modprobed snd-sb16 and 
used sox's play to play a wav. the only relevant entry in dmesg was

pnp: Device 01:01.00 activated.


pthree:/tmp# cat /proc/asound/cards
0 [S16            ]: SB16 - Sound Blaster 16
                     Sound Blaster 16 at 0x220, irq 5, dma 1&5


thanks
Fred


 > In Reply to: Tuesday January 10 2006 07:25 pm, Lee Revell Lee Revell 
<rlrevell@joe-job.com> wrote:
> On Tue, 2006-01-10 at 19:16 -0600, Fredrick O Jackson wrote:
> > ok, so far Ive tried with and without isapnp support in the kernel, I've
> > toggled the PNP OS, and ACPI switches in the bios, I've tried compiling
> > the drivers into the kernel (hd, ide, ide-disk, isapnp, ide-pnp, and
> > others) on 2.6.14, 2.6.15 and 2.4.27. I've used kernel command lines. I
> > usually get messages similar to that below (at the bottom). I also cannot
> > find the modules ide, ide-probe, or ide-detect which are documented in
> > the Documentation directory.
> >
> > what method is recommended and what kernel would you suggest?
> >
> >
> > Jan 10 12:42:41 pthree kernel: ide: failed opcode was: unknown
> > Jan 10 12:42:41 pthree kernel: ide2: reset: success
> > Jan 10 12:43:11 pthree kernel: hde: irq timeout: status=0x50 { DriveReady
> > SeekComplete }
>
> You don't say whether you are trying to use the ALSA or OSS driver.  And
> your dmesg has no mention at all of a sound card, it just shows that hde
> is failing.
>
> First, if you were trying to load the OSS driver, try the ALSA driver,
> and post the output of dmesg when loading snd-sb16 and the output of
> "cat /proc/asound/cards".
>
> Lee
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

