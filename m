Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314444AbSFXQdl>; Mon, 24 Jun 2002 12:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSFXQdk>; Mon, 24 Jun 2002 12:33:40 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:18169 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S314422AbSFXQdi>; Mon, 24 Jun 2002 12:33:38 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C057B49C9@orsmsx111.jf.intel.com>
From: "Gross, Mark" <mark.gross@intel.com>
To: "'Christopher E. Brown'" <cbrown@woods.net>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>
Cc: "'Andrew Morton'" <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: RE: [Lse-tech] RE: ext3 performance bottleneck as the number of s
	pindles gets large
Date: Mon, 24 Jun 2002 09:33:19 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are running the tests with the following mother board.
http://www.intel.com/design/servers/scb2/index.htm?iid=ipp_browse+motherbd_s
cb2&

Its a very nice box with 2 independent 64/66 PCI buses.  
Capable of 2x503MB/sec, using your logic ;)

Regardless, the 640MB/s number was computed without considering the PCI bus
limitations, or the dual port nature of the base 160MB/sec nature of the
Adabptec SCSI-39160.
http://www.adaptec.com/worldwide/product/proddetail.html?sess=no&prodkey=ASC
-39160&cat=Products

Realistically, we are looking for a max throughput of about 320MB/sec with 4
adapters with enough drives attached.

--mgross

(W) 503-712-8218
MS: JF1-05
2111 N.E. 25th Ave.
Hillsboro, OR 97124


> -----Original Message-----
> From: Christopher E. Brown [mailto:cbrown@woods.net]
> Sent: Saturday, June 22, 2002 9:03 PM
> To: Griffiths, Richard A
> Cc: 'Andrew Morton'; mgross@unix-os.sc.intel.com; 'Jens Axboe'; Linux
> Kernel Mailing List; lse-tech@lists.sourceforge.net
> Subject: [Lse-tech] RE: ext3 performance bottleneck as the number of
> spindles gets large
> 
> 
> On Thu, 20 Jun 2002, Griffiths, Richard A wrote:
> 
> > I should have mentioned the throughput we saw on 4 adapters 
> 6 drives was
> > 126KB/s.  The max theoretical bus bandwith is 640MB/s.
> 
> 
> This is *NOT* correct.  Assuming a 64bit 66Mhz PCI bus your MAX is
> 503MB/sec minus PCI overhead...
> 
> This of course assumes nothing else is using the PCI bus.
> 
> 
> 120 something MB/sec sounds a hell of a lot like topping out a 32bit
> 33Mhz PCI bus, but IIRC the earlier posting listed 39160 cards, PCI
> 64bit w/ backward compat to 32bit.
> 
> You do have *ALL* of these cards plugged into a full PCI 64bit/66Mhz
> slot right?  Not plugging them into a 32bit/33Mhz slot?
> 
> 
> 32bit/33Mhz	(32 * 33,000,000) / (1024 * 1024 * 8) = 125.89 MByte/sec
> 64bit/33Mhz	(64 * 33,000,000) / (1024 * 1024 * 8) = 251.77 MByte/sec
> 64bit/66Mhz	(64 * 66,000,000) / (1024 * 1024 * 8) = 503.54 MByte/sec
> 
> 
> NOTE: PCI transfer rates are often listed as
> 
> 32bit/33Mhz, 132 MByte/sec
> 64bit/33Mhz, 264 MByte/sec
> 64bit/66Mhz, 528 MByte/sec
> 
> This is somewhat true, but only if we start with Mbit rates as used in
> transmission rates (1,000,000 bits/sec) and work from there, instead
> of 2^20 (1,048,576).  I will not argue about PCI 32bit/33Mhz being
> 1056Mbit, if talking about line rate, but when we are talking about
> storage media and transfers to/from as measured by files remember to
> convert.
> 
> -- 
> I route, therefore you are.
> 
> 
> 
> 
> -------------------------------------------------------
> Sponsored by:
> ThinkGeek at http://www.ThinkGeek.com/
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 
