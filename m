Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbTFYP4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264651AbTFYP4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:56:49 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:23755 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S264619AbTFYP4B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:56:01 -0400
Date: Wed, 25 Jun 2003 18:11:06 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: [PATCH] unexpected IO-APIC update
In-Reply-To: <20030625085714.3cd7759e.rddunlap@osdl.org>
Message-ID: <Pine.GSO.3.96.1030625180438.19428C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003, Randy.Dunlap wrote:

> | But the ugliness part I care about, and I wonder if it wouldn't be better 
> | in this case to just make the register definition a "union", and have 
> | something like
> | 
> | 	union reg_03 {
> | 		u32 value;
> | 		struct {
> | 			u32 boot_DT:1,
> | 			    reserved:31;
> | 		} bits;
> | 	};
[...]
> Sure, I'll do that.

 Perhaps using "raw" instead of "value" would be prettier and certainly we
would save two characters per reference. ;-)  Anyway, it's indeed a good
opportunity to do a clean-up while fiddling with these bits.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

