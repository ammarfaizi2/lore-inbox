Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280273AbRKFTkT>; Tue, 6 Nov 2001 14:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280288AbRKFTkK>; Tue, 6 Nov 2001 14:40:10 -0500
Received: from delta.ds.pg.gda.pl ([213.192.72.1]:16275 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S280273AbRKFTjy>; Tue, 6 Nov 2001 14:39:54 -0500
Date: Tue, 6 Nov 2001 20:39:12 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: robert@schwebel.de, linux-kernel@vger.kernel.org
Subject: Re: ioport range of 8259 aka pic1
In-Reply-To: <3BE820A8.8B93A497@osdl.org>
Message-ID: <Pine.GSO.3.96.1011106203230.24538H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Randy.Dunlap wrote:

> The Intel chipset specs say that PIC1 uses:
>   (all hex:) 20-21, 24-25, 28-29, 2c-2d, 30-31, 34-35, 38-39, 3c-3d.
> 
> Some of the older chipset specs say that all of these other than
> 20-21 are just aliases of 20-21 (like the 440MX spec).
> Later specs don't say this (as in all of the 800-model ICH0/ICH2
> specs).

 These are chipset implementation details (i.e. address decoder's
shortcomings) only.  An 8259A only uses two I/O ports; in PC/AT systems,
these are 0x20, 0x21 and 0xa0, 0xa1 for the two PICs, respectively.  Since
the 0x00-0xff range is assigned to motherboard devices, there is no
problem with leaving aliases free -- they are never used by Linux.  You
still need to verify your extra devices are really present there. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

