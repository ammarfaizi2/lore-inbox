Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129207AbRBFSXr>; Tue, 6 Feb 2001 13:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129961AbRBFSXH>; Tue, 6 Feb 2001 13:23:07 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:17681 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129944AbRBFSW5>; Tue, 6 Feb 2001 13:22:57 -0500
Date: Tue, 6 Feb 2001 18:17:50 +0000
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA silent disk corruption - patch
Message-ID: <20010206181750.A389@colonel-panic.com>
Mail-Followup-To: pdh, Dale Farnsworth <dale@farnsworth.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010206085223.A28894@zenos.local.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010206085223.A28894@zenos.local.farnsworth.org>; from dale@farnsworth.org on Tue, Feb 06, 2001 at 08:52:23AM -0700
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 08:52:23AM -0700, Dale Farnsworth wrote:
> 
> In article <20010205190527.A314@colonel-panic.com>,
> Peter Horton <pdh@colonel-panic.com> wrote:
> > +      *  VIA VT8363 host bridge has broken feature 'PCI Master Read
> > +      *  Caching'. It caches more than is good for it, sometimes
> > +      *  serving the bus master with stale data. Some BIOSes enable
> > +      *  it by default, so we disable it.
> 
> Another data point:
> 
> I have an ASUS A7V motherboard with via vt82c686a and Promise pdc20265
> IDE controllers.  I noticed disk data corruption when I enabled DMA.     
> The corrupted data was 4K bytes long on 4K byte boundaries and occurred
> about once for every couple of gigabytes copied via cpio.
> I saw this corruption when the disks were connected to the pdc20265
> as well as to the 686a.    
> 
> I also noticed that turning off read caching eliminated the corruption.
> 
> However, if I enable the BIOS parameter "I/O Recovery Time", I can still
> enable read caching without seeing any data corruption.
> The lastest BIOS revision (1005C) enables "I/O Recovery Time" by default
> where the previous revision I had (1004D) did not.
> 

I still get corruption with "I/O Recovery Time" enabled :-(

I don't get corruption with the BIOS "normal" settings (1004D).

I might update my BIOS to the latest BIOS in case it changes any other
settings.

P.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
