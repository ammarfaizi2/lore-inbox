Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267989AbTAHVNf>; Wed, 8 Jan 2003 16:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267990AbTAHVNf>; Wed, 8 Jan 2003 16:13:35 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:5360 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S267989AbTAHVNe>; Wed, 8 Jan 2003 16:13:34 -0500
Date: Wed, 8 Jan 2003 22:22:14 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI code:  why need  outb (0x01, 0xCFB); ?
In-Reply-To: <CACAEBD1F1C@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1030108221508.11293D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, Petr Vandrovec wrote:

> > > 1. which device is at port address 0xCFB?
> > 
> > Hopefully none.
> 
> Actually I'm not sure. This code is here since at least 2.0.28,
> and during googling I even found code for direct PCI access
> (http://www-user.tu-chemnitz.de/~heha/viewzip.cgi/hs_freeware/gerald.zip/DIRECTNT.CPP?auto=CPP)
> which sets lowest bit at 0xCFB to 1 before doing PCI config
> accesses and reset it back to original value afterward.
> 
> So I believe that there were some chipsets (probably in 486&PCI times)
> which did conf1/conf2 accesses depending on value of this bit.
> Unfortunately I was not able to confirm this - almost nobody provides
> northbridge datasheets from '94 era, even Intel does not provide them
> (f.e. Neptune) anymore :-(

 Fortunately that's not true.  Grab the relevant docs from: 
'ftp://download.intel.com/support/chipsets/430nx/'.  The semantics of
0xcf8, 0xcf9, 0xcfa and 0xcfb I/O ports when used as byte quantities is
explained there.  Note that 0xcf8 and 0xcfa are the way to get at the PCI
config space using conf2 accesses. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

