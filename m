Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285166AbRLXRDS>; Mon, 24 Dec 2001 12:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285169AbRLXRDL>; Mon, 24 Dec 2001 12:03:11 -0500
Received: from fepC.post.tele.dk ([195.41.46.147]:6305 "EHLO fepC.post.tele.dk")
	by vger.kernel.org with ESMTP id <S285166AbRLXRC5>;
	Mon, 24 Dec 2001 12:02:57 -0500
Date: Mon, 24 Dec 2001 18:02:44 +0100
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011224180244.C1241@suse.de>
In-Reply-To: <20011221091104.A120@earthlink.net> <20011221154654.E811@suse.de> <20011221185538.A131@earthlink.net> <20011224150337.A593@suse.de> <20011224115953.A118@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011224115953.A118@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24 2001, rwhron@earthlink.net wrote:
> On Mon, Dec 24, 2001 at 03:03:37PM +0100, Jens Axboe wrote:
> > On Fri, Dec 21 2001, rwhron@earthlink.net wrote:
> > What IDE controller are you using? The two other reports so far have
> > been with VIA, maybe that's a clue.
> 
> I do have one of the perhaps buggier VIA chipsets.  
> 
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
> 00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
> 00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
> 00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)
> 
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
> 	Subsystem: VIA Technologies, Inc. Bus Master IDE
> 	Flags: bus master, medium devsel, latency 32
> 	I/O ports at d000 [size=16]
> 	Capabilities: <available only to root>
> 
> It's been reliable for a long time, but it wouldn't compile an Athlon 
> optimized kernel until 2.4.1x.  (Kernel would Oops at boot time unless 
> compiled with CONFIG_M586=y)

Ok noted

> > Anyways, could you please reproduce with this applied?
> > 
> > -- 
> > Jens Axboe
> 
> With the patch, it still hangs on this system.  I recompiled with
> CONFIG_NOHIGHMEM=y and CONFIG_M586=y, but that ended up with all processes 
> in "b" state during dbench 32 too.

I would suspect that, do you get any kernel messages?

> I tried unpatched 2.5.2-pre1 on a k6-2.  dbench 32 hung similarly with 
> 32 in "b", bo and bi = 0, and id = 100.  That machine is ill now and can't
> find "init" when booting, boot single, or boot init=/bin/bash.

Please send ps -eo cmd,wchan info for a hung machine.

-- 
Jens Axboe

