Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbUKQBCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbUKQBCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 20:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUKQBCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 20:02:52 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:14862 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262146AbUKQBCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 20:02:45 -0500
Date: Wed, 17 Nov 2004 01:02:36 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Hiroshi Itoh <hiroit@mcn.ne.jp>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, csapuntz@stanford.edu,
       linux-kernel@vger.kernel.org, Nickolai Zeldovich <kolya@MIT.EDU>
Subject: Re: [patch] Fix GDT re-load on ACPI resume
In-Reply-To: <004701c4cc04$2fcbaff0$2000a8c0@TPHIROIT>
Message-ID: <Pine.LNX.4.58L.0411170048350.1930@blysk.ds.pg.gda.pl>
References: <16A54BF5D6E14E4D916CE26C9AD305758EF0BA@pdsmsx402.ccr.corp.intel.com>
 <Pine.LNX.4.58L.0411161237020.17411@blysk.ds.pg.gda.pl>
 <004701c4cc04$2fcbaff0$2000a8c0@TPHIROIT>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hiroshi-san,

> I believe this patch is required because the original gdt is not addressable
> via the low mapping page table (set by acpi_save_state_mem and used for wakeup
> code), not the GDTR's linear address size reason.

 That makes sense, indeed.  Using "lgdtl" (and likewise "lidtl")  
universally is a bit safer anyway.

  Maciej
