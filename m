Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbTCVPL5>; Sat, 22 Mar 2003 10:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262037AbTCVPL5>; Sat, 22 Mar 2003 10:11:57 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34202
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261916AbTCVPL4>; Sat, 22 Mar 2003 10:11:56 -0500
Subject: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030322140337.GA1193@brodo.de>
References: <20030322140337.GA1193@brodo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048350905.9219.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 16:35:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 14:03, Dominik Brodowski wrote:
> hda: host protected area => 1
> hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=159560/16/63, UDMA(100)
>  hda: [PTBL] [10011/255/63] hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
> 
> and *deadlock*...

Where is the lock, what does the NMI oopser show ?

> in plain 2.5.65 I was seeing strange error messages like:
> 
> Mar 19 20:29:55 mondschein kernel: hda: dma_timer_expiry: dma status == 0x24
> Mar 19 20:29:55 mondschein kernel: hda: lost interrupt
> Mar 19 20:29:55 mondschein kernel: hda: dma_intr: bad DMA status (dma_stat=30)
> Mar 19 20:29:55 mondschein kernel: hda: dma_intr: status=0x52 { DriveReady SeekComplete Index }
> Mar 19 20:29:55 mondschein kernel:

I've seen 3 or 4 reports of this, none of them duplicatable with the same IDE
code on 2.4 so far. Which is odd but I don't yet understand what is going on.

