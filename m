Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbRLKQq2>; Tue, 11 Dec 2001 11:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281915AbRLKQqK>; Tue, 11 Dec 2001 11:46:10 -0500
Received: from [12.234.19.19] ([12.234.19.19]:63756 "HELO ocean.lucon.org")
	by vger.kernel.org with SMTP id <S281912AbRLKQpz>;
	Tue, 11 Dec 2001 11:45:55 -0500
Date: Tue, 11 Dec 2001 08:45:52 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ben Collins <bcollins@debian.org>
Cc: Linux 1394 <linux1394-devel@lists.sourceforge.net>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Slow Disk I/O with QPS M3 80GB HD
Message-ID: <20011211084552.A25750@lucon.org>
In-Reply-To: <20011210203452.A3250@lucon.org> <20011210235708.A17743@lucon.org> <20011211110507.H22537@visi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011211110507.H22537@visi.net>; from bcollins@debian.org on Tue, Dec 11, 2001 at 11:05:07AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 11:05:07AM -0500, Ben Collins wrote:
> On Mon, Dec 10, 2001 at 11:57:08PM -0800, H . J . Lu wrote:
> > On Mon, Dec 10, 2001 at 08:34:52PM -0800, H . J . Lu wrote:
> > > I have a very strange problem. The disk I/O of my QPS M3 80GB HD is
> > > very slow under 2.4.10 and above. I got like 1.77 MB/s from hdparm.
> > > But under 2.4.9, I got 14 MB/s on the same hardware. A 30GB HD has
> > > consistent I/O performance under 2.4.9 and above on the same bus. Has
> > > anyone else seen this? Does anyone have a large (>= 80GB) 1394 HD?
> > > 
> > 
> > I did a binary search. 2.4.10-pre10 is the last good kernel. I got
> > 
> > # hdparm -t /dev/sda
> > 
> > /dev/sda:
> >  Timing buffered disk reads:  64 MB in  4.40 seconds = 14.55 MB/sec
> 
> Have you checked the way that your ohci and sbp2 devices are detected
> under each case? Most notably the max packet size.
> 

They all say

ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[19]  MMIO=[f8ffd000-f8ffe000]  Max Packet=[1024]
ieee1394: sbp2: SBP-2 device max speed S200 and payload 1KB


H.J.
