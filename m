Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274524AbRITTYV>; Thu, 20 Sep 2001 15:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274618AbRITTYL>; Thu, 20 Sep 2001 15:24:11 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:7947 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S274524AbRITTYC>;
	Thu, 20 Sep 2001 15:24:02 -0400
Date: Thu, 20 Sep 2001 21:24:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Balazic <david.balazic@uni-mb.si>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        andre@linux-ide.org
Subject: Re: Linux not detecting ide0
Message-ID: <20010920212425.A13270@suse.cz>
In-Reply-To: <3BAA333F.64725B02@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BAA333F.64725B02@uni-mb.si>; from david.balazic@uni-mb.si on Thu, Sep 20, 2001 at 08:19:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 08:19:43PM +0200, David Balazic wrote:
> I discovered some weird behavior in IDE interface handling.
> I some cases linux detects the ide1 channel , but not ide0.
> More precisely , it prints a line like :
> 
> ide0: BM-DMA xxxxxx
> 
> but that is it. Nothing else. No line of :
> 
> ide0:  at 0x0170 blah blah 
> 
> no drives on the channel are recognized.
> No ide0 entry in /proc/devices 
> etc.
> 
> ide1 and the devices on it are more or less OK. ( I didn't notice
> any problems, but it is hard to test if linux does not see the root
> fs on hda ! )
> 
> I tested the redhat kernel-2.4.7-10 and vanilla linux 2.4.9.
> 
> Hardware details :
> - MSI K7T Pro2A motherboard , BIOS v2.9 , VIA KT133 chipset, via 686b southbridge
> - hda is an IBM Deskstar 75GXP 45 GB hard drive ( DTLA-307045 ) ( 80-wire cable,
>     cable-select , connected to the end of the cable, thus master )
> - hdb : none
> - hdc : Acer 1208A CD-RW drive ( cable select (master))
> - hdd : Teac CD532E-B CD-ROM ( cable select (slave))    80-wire cable
> 
> The way to trigger this is to set one of the IDE devices in BIOS to wrong geometry.
> Maybe it is a BIOS bug.
> 
> I some cases I also got a weird line from linux :
> hd1: C/H/S=0/0/0 from BIOS ignored
> 
> I thought that disk are enumerated by letter only, not numbers.
> ( it is H-D-one , not H-D-ell, in case you have a funny font )

Have you by any chance set "Use old disk-only driver on primary
interface" to yes? That would explain things ...

-- 
Vojtech Pavlik
SuSE Labs
