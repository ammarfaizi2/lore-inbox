Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRDMNLI>; Fri, 13 Apr 2001 09:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131244AbRDMNK6>; Fri, 13 Apr 2001 09:10:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1292 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131191AbRDMNKt>; Fri, 13 Apr 2001 09:10:49 -0400
Subject: Re: Data-corruption bug in VIA chipsets
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Date: Fri, 13 Apr 2001 14:11:45 +0100 (BST)
Cc: db@zigo.dhs.org (Dennis Bjorklund), linux-kernel@vger.kernel.org,
        andre@linux-ide.org (Andre Hedrick), vojtech@suse.cz (Vojtech Pavlik)
In-Reply-To: <20010413114456.C682@nightmaster.csn.tu-chemnitz.de> from "Ingo Oeser" at Apr 13, 2001 11:44:56 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14o3MZ-0002r6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These are the things, that one of the German links[1] suggest
> (translated only, because I'm not the IDE guy ;-)):
>    
>    - PCI Delay Transaction = 0 (off) (Register 0x70, Bit 1)
>    - PCI Master Read Caching = 0 (off) (Register 0x70, Bit 2)
>    - PCI Latency = 0 (values between 0 and 32 *seem* to be safe,
>         everything above seems to be *not* !)
> 
> Note: This also fixes some related USB issues according to [1].

If you set the latency only within 0 and 32 then numerous other cards will
stop working (because they set the latency up to fix pci bugs or get
performance) - eg the buslogic scsi cards set the latency in their bios. The
3c59x needs a high value.

The values they quote are ones people tried and they were pulled because those
were the values that generated all the 'my tv card has broken' 'my ethernet
stopped working' reports. 

Alan

