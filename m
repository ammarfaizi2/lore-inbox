Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268914AbUIHHho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268914AbUIHHho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 03:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268907AbUIHHho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 03:37:44 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:38613 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S268914AbUIHHhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 03:37:35 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: Fw: Oops at bttv_risc_packed (2.6.8-rc1)
Date: Wed, 8 Sep 2004 09:37:08 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040804212106.04f19bad.akpm@osdl.org> <20040817142255.GA18704@bytesex>
In-Reply-To: <20040817142255.GA18704@bytesex>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_karPB3VZa8OsAXh"
Message-Id: <200409080937.08248.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_karPB3VZa8OsAXh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 17 August 2004 16:22, Gerd Knorr wrote:
> > DEBUG_PAGEALLOC
> 
> Hmm, amd64 hasn't this one?
> 
> >  [pg0+543078197/1069322240] bttv_buffer_risc+0x4b5/0x5b0 [bttv]
> 
> Looks like the buffer for the risc instructions overflows.  No idea why
> through, the size calculation looks ok.  Can you please apply the debug
> patch below, load bttv with "bttv_debug=1" insmod option and try again?
> 
> What app triggers this btw, and which capture parameters (size, format)?

Hi Gerd, I haven't been able to capture a new oops - but I continue to get
the usual hard hangs.  Here's the output before a hang, captured using
netconsole.  The app is xawtv, using PAL composite video.  I've attached
the xawtv verbose output (for a different run).  The time between starting and
hanging was around one minute.  I don't see anything strange...

All the best,

Duncan.

bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:00:08.0, irq: 19, latency: 32, mmio: 0xdfbfe000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
tuner: chip found at addr 0xc2 i2c-bus bt878 #0 [sw]
bttv0: i2c attach [client=(tuner unset)]
bttv0: Hauppauge eeprom: model=44806, tuner=Philips FI1216MF MK2 (3), radio=no
bttv0: using tuner=3
tuner: type set to 3 (Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF, FR1216MF)) by bt878 #0 [sw]
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 . ok
bttv0: PLL: no change required
switch_overlay: enter [new=dddf6360]
switch_overlay: done
bttv0: next set: top=dddf6360 bottom=dddf6360 [screen=dddf6360,irq=0,0]
switch_overlay: enter [new=dddf6578]
switch_overlay: old=dddf6360 state is 3
bttv0: next set: top=dddf6578 bottom=dddf6578 [screen=dddf6578,irq=0,0]
switch_overlay: done
switch_overlay: enter [new=dddf6254]
switch_overlay: old=dddf6578 state is 3
bttv0: next set: top=dddf6254 bottom=dddf6254 [screen=dddf6254,irq=0,0]
switch_overlay: done
switch_overlay: enter [new=dddf6ab4]
switch_overlay: old=dddf6254 state is 3
bttv0: next set: top=dddf6ab4 bottom=dddf6ab4 [screen=dddf6ab4,irq=0,0]
switch_overlay: done
switch_overlay: enter [new=dddf69a8]
switch_overlay: old=dddf6ab4 state is 3
bttv0: next set: top=dddf69a8 bottom=dddf69a8 [screen=dddf69a8,irq=0,0]
switch_overlay: done
switch_overlay: enter [new=dddf689c]
switch_overlay: old=dddf69a8 state is 3
bttv0: next set: top=dddf689c bottom=dddf689c [screen=dddf689c,irq=0,0]
switch_overlay: done
switch_overlay: enter [new=dddf6ab4]
switch_overlay: old=dddf689c state is 3
bttv0: next set: top=dddf6ab4 bottom=dddf6ab4 [screen=dddf6ab4,irq=0,0]
switch_overlay: done
switch_overlay: enter [new=dddf6254]
switch_overlay: old=dddf6ab4 state is 3
bttv0: next set: top=dddf6254 bottom=dddf6254 [screen=dddf6254,irq=0,0]
switch_overlay: done
switch_overlay: enter [new=dddf689c]
switch_overlay: old=dddf6254 state is 3
bttv0: next set: top=dddf689c bottom=dddf689c [screen=dddf689c,irq=0,0]
switch_overlay: done

...hung...

--Boundary-00=_karPB3VZa8OsAXh
Content-Type: application/x-gzip;
  name="xawtv.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="xawtv.log.gz"

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

--Boundary-00=_karPB3VZa8OsAXh--
