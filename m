Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbRDGUnl>; Sat, 7 Apr 2001 16:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131873AbRDGUnb>; Sat, 7 Apr 2001 16:43:31 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:2292 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131626AbRDGUnV>; Sat, 7 Apr 2001 16:43:21 -0400
Message-ID: <3ACF7D1E.6EAB0149@redhat.com>
Date: Sat, 07 Apr 2001 16:48:30 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Naren Devaiah <naren@cs.pdx.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: i810_audio.c: Clicks while playing audio
In-Reply-To: <Pine.GSO.4.21.0104071130340.7196-100000@spica.cs.pdx.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Naren Devaiah wrote:
> 
> Hi,
> 
> On a HP Vectra VL 400 with a i815 motherboard playing a .wav file (haven't
> tried anything else) causes the sound to be played with a lot of periodic
> clicks.
> The kernel is 2.4.3
> dmesg shows:
> Intel 810 + AC97 Audio, version 0.01, 17:25:00 Apr  6 2001
> PCI: Enabling device 00:1f.5 (0000 -> 0001)
> PCI: Found IRQ 9 for device 00:1f.5
> PCI: The same IRQ used for device 00:1f.3
> PCI: Setting latency timer of device 00:1f.5 to 64
> i810: Intel ICH 82801AA found at IO 0x1300 and 0x1200, IRQ 9
> ac97_codec: AC97 Audio codec, id: 0x4352:0x5934 (Cirrus Logic CS4299)
> i810_audio: 9568 bytes in 50 milliseconds
> i810_audio: DMA overrun on send
> i810_audio: DMA overrun on send
> 
> lsmod show:
> root@darkstar:~# lsmod
> Module                  Size  Used by
> i810_audio             14084   0
> ac97_codec              7908   0  [i810_audio]
> 
> My question is: What does "DMA overrun on send" mean?

It means it sounds like you have an older version of the driver (older here
means "not my latest patch").  I sent my stuff to Alan, and it was in the ac
series kernels, but I don't know what happened to make it into 2.4.3.  I'm
fixing one last known bug in the driver tonight, and when I'm done I'll put a
patch against 2.4.3 on my web site and drop a note here.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
