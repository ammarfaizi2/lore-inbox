Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSKIArO>; Fri, 8 Nov 2002 19:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263345AbSKIArO>; Fri, 8 Nov 2002 19:47:14 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:40710 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263333AbSKIArO>; Fri, 8 Nov 2002 19:47:14 -0500
Date: Sat, 9 Nov 2002 00:53:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: Re: [PATCH] SCSI on non-ISA systems
Message-ID: <20021109005344.A26065@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Russell King <rmk@arm.linux.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Rusty Trivial Russell <trivial@rustcorp.com.au>
References: <20021108135742.A22790@flint.arm.linux.org.uk> <Pine.GSO.4.21.0211081522050.23267-100000@vervain.sonytel.be> <20021108144234.A24114@flint.arm.linux.org.uk> <1036772421.16651.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1036772421.16651.10.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Nov 08, 2002 at 04:20:21PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 04:20:21PM +0000, Alan Cox wrote:
> On Fri, 2002-11-08 at 14:42, Russell King wrote:
> > Probably the correct answer is to get everyone to use an explicit release
> > function and just kill scsi_host_generic_release() entirely.
> > 
> > However, I'm sure other people will have differing views on that.
> 
> There are three things I'd like to do in that area
> 
> 1.	Make a release function mandatory (and I'm happy to paste it into the
> old scsi drivers)

No.  I restructured the BHA interfaces to get rid of ->detect and
->release.  Makeing it mandatory is a step backwards.  Not having a
default fallback is a good idea, though.

