Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUJGRqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUJGRqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUJGRot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:44:49 -0400
Received: from fmr12.intel.com ([134.134.136.15]:38351 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S267565AbUJGRGa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:06:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] 2.6 SGI Altix I/O code reorganization
Date: Thu, 7 Oct 2004 10:06:14 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F022669A9@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6 SGI Altix I/O code reorganization
Thread-Index: AcSsjgZ7CokWv96ARs+BMDpP7Ie4wgAAECUg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Jesse Barnes" <jbarnes@engr.sgi.com>, "Patrick Gefre" <pfg@sgi.com>
Cc: "Grant Grundler" <iod00d@hp.com>, "Colin Ngam" <cngam@sgi.com>,
       "Matthew Wilcox" <matthew@wil.cx>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 07 Oct 2004 17:06:14.0955 (UTC) FILETIME=[F4247FB0:01C4AC8F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Yeah, sorry, I shouldn't have said cleanup, fixup is better.  
>Anyway, they 
>need to be separate since they'll be going into the tree via 
>Andrew not Tony.

A couple of days back I said that I'm ok pushing these drivers.
Although they don't have "arch/ia64" or "include/asm-ia64"
prefixes, they are only used by ia64.  I'm even ok with the
qla1280.c change as the final version is only touching code
inside #ifdef CONFIG_IA64_{GENERIC|SN2) ... but I would like
to see a sign-off from the de-facto maintainer Christoph for
this file.

This is not a land-grab to expand my responsibilities, it just
seems to be the right thing to do to coordinate getting all
these interdependent pieces into the tree at the same time.

However ... there's a thread on LKML wailing about huge changes
going into "-rc" releases.  Since there still seems to be
a lively discussion about the the right way to do the pci_root
bits of this patch, I'm very inclined to save this till *after*
Linus release 2.6.9-final.  If there's a _mostly_ clean patch
presented to me before 2.6.10-rc1 shows up, I'll push that and
allow for some follow-on tidy-up patches to clean up.

-Tony
