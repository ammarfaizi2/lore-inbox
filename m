Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135409AbRAJMMM>; Wed, 10 Jan 2001 07:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135412AbRAJMMC>; Wed, 10 Jan 2001 07:12:02 -0500
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:10212 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S135409AbRAJML5>; Wed, 10 Jan 2001 07:11:57 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101101206.f0AC68N00684@wittsend.ukgateway.net>
Subject: Request for Data: Anyone out there with an ENSONIQ SoundScape?
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Date: Wed, 10 Jan 2001 12:06:07 +0000 (GMT)
Reply-To: rankinc@zip.com.au
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to add ISA-PNP support to the ENSONIQ SoundScape driver,
but am suffering from a lack of examples: the only one I have is my
own. Can anyone who is using the sscape.o driver to control their
soundcard please email me with their working module parameters, plus
the output from either pnpdump or /proc/isapnp? And if you have a
SoundScape which doesn't have any pnpdump or /proc/isapnp output, then
can you tell me about your card too?

For example, my Soundscape has this ISA-PNP output:

# more /proc/isapnp 
Card 1 'ENS3081:ENSONIQ Soundscape' PnP version 1.0
  Logical device 0 'ENS0000:Unknown'
    Device is active
    Active port 0x330,0x300
    Active IRQ 5 [0x2],9 [0x2]
    Active DMA 1,3
    Resources 0
      Priority preferred
      Port 0x330-0x330, align 0xf, size 0x10, 16-bit address decoding
      IRQ 5,7 High-Edge
      IRQ 2/9 High-Edge
      DMA 1 8-bit byte-count compatible
      DMA 0,3 8-bit byte-count compatible
...

And uses these module options:
options sscape irq=5 dma=1 io=0x338 mpu_io=0x330 mpu_irq=9

Cheers,
Chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
