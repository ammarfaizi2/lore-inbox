Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285129AbRLFNvs>; Thu, 6 Dec 2001 08:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285131AbRLFNvi>; Thu, 6 Dec 2001 08:51:38 -0500
Received: from mplspop5.mpls.uswest.net ([204.147.80.2]:14347 "HELO
	mplspop5.mpls.uswest.net") by vger.kernel.org with SMTP
	id <S285129AbRLFNva>; Thu, 6 Dec 2001 08:51:30 -0500
Date: Thu, 6 Dec 2001 07:51:26 -0600
Message-ID: <20011206075125.A23432@beaver.iucha.org>
From: "Florin Iucha" <florin@iucha.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Florin Iucha" <florin@iucha.net>, linux-kernel@vger.kernel.org,
        faith@acm.org
Subject: Re: Adaptec-2920 eats too much cpu time when reading from the CD-ROM
In-Reply-To: <20011206030154.GA5979@iucha.net> <E16Bup6-00012G-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Bup6-00012G-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 06, 2001 at 09:28:08AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 09:28:08AM +0000, Alan Cox wrote:
> > I have recently purchased a Plextor 12x CD-RW and I have attached it to
> > and Adaptec-2920 SCSI card. The card uses the "Future Domain Corp. TMC-18C30
> > [36C70]" chip.
> > 
> > The problem I see: when reading from the CD-RW my system becomes very
> > unresponsive and top reveals 90-95% of the time is spent on "system".
> > My CPU is AMD K6-III/500MHz with 256 Mb RAM.
> 
> I'd expect that. The 2920 is pretty old. It has no DMA channel and several
> processes it must perform are polled not interrupt driven.

There is one interesting thing about it: when I write a CD, I write at 12x
- that means 1800Kb/s, which is comparable with the reading speed of 2400Kb/s.
But when writing, the system CPU usage is about 30%.

What could make the controller eat so much time when reading but not when
writing?

Thanks,
florin

PS. The patch fixes the "bad boy" message.

-- 

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
