Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135979AbRD0FeD>; Fri, 27 Apr 2001 01:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135981AbRD0Fdx>; Fri, 27 Apr 2001 01:33:53 -0400
Received: from penguin-ext.wise.edt.ericsson.se ([194.237.142.110]:18062 "EHLO
	penguin-ext.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S135979AbRD0Fde>; Fri, 27 Apr 2001 01:33:34 -0400
Date: Fri, 27 Apr 2001 13:47:54 +0800 (SGT)
From: Gregory Hosler <gregory.hosler@eno.ericsson.se>
Subject: via82cxxx_audio & SMP
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: gregory.hosler@eno.ericsson.se
Message-id: <XFMail.010427134754.gregory.hosler@eno.ericsson.se>
Organization: Ericsson Telecommunications, Pte Ltd
MIME-version: 1.0
X-Mailer: XFMail 1.3 [p0] on Linux
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 8bit
X-Priority: 3 (Normal)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an onboard AC97 detected as:

   kernel: Via 686a audio driver 1.1.14b
   kernel: via82cxxx: Codec rate locked at 48Khz
   kernel: ac97_codec: AC97 Audio codec, id: 0x5745:0x4301 (Unknown)
   kernel: via82cxxx: IRQ fixup, 0x3C==0x12
   kernel: via82cxxx: board #1 at 0x9C00, IRQ 18

My motherboard is a MSI-6321 (duap CPU).

This sound chip works fine under 2.2.x kernel, and works under 2.4.3 single
processor kernel. but under the SMP kernel it really doesn't work. it repeats
(forever) the 1st phrase/tone sent to the sound device.

for example, I was having problems in gnome (sound sounded like a tapdancer),
so I decided to logout, kill esd, login as root, and run sndconfig.

sndconfig sees the AC97 pci sound chip properly, but when it goes to
play the sample sound, all I get is an infinite loop of Linus repeating
"Hi, Hi, Hi, Hi, Hi, ..." instead of "Hi, I'm Linus, and I ...".

this is the latest driver (1.1.14b)

any thoughts or suggestions. I am willing to put in kprint statements, and
collect debugging info and/or assist in debugginbg this.

thank you, and regards,

-Greg Hosler

----------------------------------
E-Mail: Gregory Hosler <gregory.hosler@eno.ericsson.se>
Date: 27-Apr-01
Time: 13:39:14

   You can release software that's good, software that's inexpensive, or
   software that's available on time.  You can usually release software
   that has 2 of these 3 attributes -- but not all 3.

----------------------------------
