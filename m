Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVIKGHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVIKGHX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 02:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVIKGHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 02:07:23 -0400
Received: from fmr16.intel.com ([192.55.52.70]:58832 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S932414AbVIKGHX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 02:07:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: new asm-offsets.h patch problems
Date: Sat, 10 Sep 2005 23:07:21 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F045A8DF3@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: new asm-offsets.h patch problems
Thread-Index: AcW2lxIub4gtaboUTLufFFpNztL91g==
From: "Luck, Tony" <tony.luck@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Sep 2005 06:07:22.0165 (UTC) FILETIME=[12CCB650:01C5B697]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sometimes ending up with just "#define IA64_TASK_SIZE 0"
in include/asm-ia64/asm-offsets.h ... but only sometimes.

My build script does "make prepare; make -j8" ... so I guess
there are some races in the parallel build?  The "make prepare"
part used to do the full of build offsets.h, but now it just does
the ia64 hack.

-Tony
