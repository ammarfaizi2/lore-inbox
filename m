Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263374AbTDVS5f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTDVS5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:57:35 -0400
Received: from [63.246.199.14] ([63.246.199.14]:60033 "EHLO ns.briggsmedia.com")
	by vger.kernel.org with ESMTP id S263374AbTDVS5c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:57:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: andras@t-online.de (Andreas Arens), linux-kernel@vger.kernel.org,
       motion@pdx.frogtown.com
Subject: Re: IDE corruption during heavy bt878-induced interrupt load [LKM]
Date: Tue, 22 Apr 2003 16:09:18 -0400
User-Agent: KMail/1.4.3
References: <200304222048.41595.andras@t-online.de>
In-Reply-To: <200304222048.41595.andras@t-online.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304221609.18961.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to mention 2.4.19 on Debian Woody, GigaByte GA-7VAXP/Athlon 
MX2500/512 MB (and several other Intel motherboards).

I am glad that you mentioned ext3 because while I curse ReiserFS, I really 
don't think that it is part of the problem. Definately PCI-dma related, but 
does onboard IDE (i.e., my system disk) use DMA in the same way that a PCI 
adapter such as Promise does? 

On Tuesday 22 April 2003 02:48 pm, you wrote:
> >I create multi-channel digital surveillance systems using cards with 4 or
> > more multiplexed bt878 framegrabbers; each one capturing 5 or more frames
> > per second on each of its two input channels (total 4 * 2 * 5 = 40 fps).
> > Typically I run using either a Promise or Adaptec HPT370 IDE-RAID
> > controller with 2 WD-120GB/8MB-cache drives striped in RAID-0, with
> > another IDE as hda for my system drive. What happens is that every few
> > seconds I get a "BTTV: RISC ERROR - resetting" from the frame grabber
> > driver. After a few days of this I have corruption on my Reiser file
> > system; which usually I am able to clean up with mkreiserfs --fix-fixable
> > or --rebuild-tree. The corruption is both on my RAID and my system drive.
> > Missing doing this maintenance action can really ruin my day.
> >
> >All comments/suggestions/etc. appreciated.
> >
> >Joe
>
> Hi,
>
> I'm seeing the same type of corruption (kernel 2.4.21pre7-ac1+acpi) when
> mencoding from BT878 to ext3 on ide raid1 (VIA 8233A on-board ide) with
> single 25 FPS. The kernel even oopsed on umount of the array, showing signs
> of memory corruption.
> I haven't come far with investigation, since I cannot affort to ruin that
> (production) system, however it seems clear to me that the v4l driver is
> the culprit. We also thought of dma contention, so my next test will be to
> switch the drives to PIO, to see if the dma traffic reduction helps.
>
> If you find some solution, please let me know
>
> Best Regards
> Andy

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL/FAX 603-232-3115 MOBILE 603-493-2386
www.briggsmedia.com
