Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbUKEXNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUKEXNZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbUKEXNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:13:24 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:43446 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S261253AbUKEXNV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:13:21 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: KSTK_EIP and KSTK_ESP
Date: Fri, 5 Nov 2004 16:13:10 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C20542CA19@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: KSTK_EIP and KSTK_ESP
Thread-Index: AcTDjQQ7W72syMm+QfuJCaPlPzAL7A==
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Nov 2004 23:13:12.0397 (UTC) FILETIME=[058A47D0:01C4C38D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I'm trying to figure out the magic that's going on in KSTK_EIP
and KSTK_ESP, which are defined as macros in
include/asm-i386/processor.h for a 2.4 kernel. Here are their
definitions below:

#define KSTK_EIP(tsk) (((unsigned long *)(4096 + (unsigned
long)(tsk)))[1019])
#define KSTK_ESP(tsk) (((unsigned long *)(4096 + (unsigned
long)(tsk)))[1022])

I know that the memory allocated to the process to hold its descriptor
and stack by the kernel is two pages. Both of the above macros appear to
go half-way up the allocated memory and then skip to the offsets of 1019
and 1022, respectively, down the allocated memory.
	Can someone explain the structure of the memory that these two
macros are accessing? Specifically, where do the 1019 and 1022 offsets
come from? Also, what other things are stored at other offsets? Where is
this stack structure defined?
	Thanks you for your help in advance.

