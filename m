Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131810AbRA3SSp>; Tue, 30 Jan 2001 13:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131870AbRA3SSf>; Tue, 30 Jan 2001 13:18:35 -0500
Received: from mail.zmailer.org ([194.252.70.162]:7186 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S131810AbRA3SS2>;
	Tue, 30 Jan 2001 13:18:28 -0500
Date: Tue, 30 Jan 2001 20:18:18 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Pekka Pietikainen <pp@evil.netppl.fi>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Dolphin PCI-SCI RPM Drivers 1.1-4 released
Message-ID: <20010130201818.X25659@mea-ext.zmailer.org>
In-Reply-To: <20010129164953.A15219@vger.timpanogas.org> <Pine.A41.4.31.0101292123270.54650-100000@aix06.unm.edu> <20010130101958.A18047@vger.timpanogas.org> <20010130192248.A3684@netppl.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010130192248.A3684@netppl.fi>; from pp@evil.netppl.fi on Tue, Jan 30, 2001 at 07:22:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 07:22:48PM +0200, Pekka Pietikainen wrote:
> On Tue, Jan 30, 2001 at 10:19:58AM -0700, Jeff V. Merkey wrote:
> > On Mon, Jan 29, 2001 at 09:41:21PM -0700, Todd wrote:
> > 
> > Sparc servers.  The adapters these drivers I posted support are a bi-CMOS 
> > implementation of the SCI LC3 chipsets, and even though they are 
> > bi-CMOS, the Link speed on the back end is still 500 MB/S --
> > very respectable.
> Sounds impressive (and expensive)

  Impressive yes, expensive ?  Everything is relative.

  Well, you can propably buy a truck-load of cheap 100BaseT cards
  with the price of Sun UPA connected SCI interface, but there is
  no point at connecting SCI anywhere but into the system core bus.

  PCI is "mediocre speed" IO-bus, never forget that.
  (But there is nothing better yet!  66+MHz 64bit PCI-X gives some
   hope for faster IO-busses, but is still quite inadequate..)

  People who want to use SCI have serious nonccNUMA PVM programs
  (Beowulf-like) where interconnect message latency may well be
  the difference in between a successfull system, and failure.
  (Even when all optimization is pushed into extreme and as little,
  and infrequent interconnect messages are needed as possible with
  given problem.  Reminds me of solving partial differential equations
  via FFT method in parallel system -- interconnect memory access speeds
  ruled the result.  Nothing beats Cray T3E there yet.)

  Giga-Ethernet has 9.9 Gbit/sec mode, as well as something close
  to 40 Gbit/sec.  Those may yet be superior interconnects - or
  maybe not.  Throwing around Ethernet frames is non-trivial task
  compared to SCI.   But what may yet emerge are chipsets and system
  busses able to sustain that kind of traffics, and optimize operation
  for SCI.   40GE uses bits serial optical transmission at 40+ GHz ...
  (E.g. 18/16 encoded codewords, or some such.  FE uses 5/4 encoding,
   if I remember correctly.)

> -- 
> Pekka Pietikainen

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
