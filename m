Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbTIKMOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 08:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbTIKMOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 08:14:12 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:19117 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S261255AbTIKMOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 08:14:11 -0400
Date: Thu, 11 Sep 2003 14:10:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
In-Reply-To: <20030911062816.GX27368@fs.tum.de>
Message-ID: <Pine.GSO.3.96.1030911134447.28174B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003, Adrian Bunk wrote:

> - X86_GOOD_APIC: Are there really that many processors with a bad APIC?

 Only early revisions of the P54C (75-200MHz) Pentium processors are
affected: steppings B1, B3, B5, C2 and cB1 (or 1, 2, 4, 5 and 11) as
reported by cpuid).  MMX Pentia and later chips are OK as well as any
systems using external i82489DX APICs (so far i486, P5 (60/66MHz) Pentium
and P54C Pentium systems with i82489DX APICs has been found, AFAIK).  Once
I proposed the option to be user-selectable as an advanced CPU option
(<asm/bugs.h> does appropriate validation), but the proposal was rejected
as incomprehesible to an average user doing a kernel build. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

