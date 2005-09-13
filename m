Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVIMAOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVIMAOO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 20:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVIMAON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 20:14:13 -0400
Received: from fmr15.intel.com ([192.55.52.69]:458 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S932225AbVIMAON convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 20:14:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: new asm-offsets.h patch problems
Date: Mon, 12 Sep 2005 17:14:01 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F045EB0BC@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: new asm-offsets.h patch problems
Thread-Index: AcW391YCpFLFOwvzTdmmqlesMiG2UgAAD7Pw
From: "Luck, Tony" <tony.luck@intel.com>
To: "Peter Chubb" <peterc@gelato.unsw.edu.au>
Cc: "Sam Ravnborg" <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Sep 2005 00:14:02.0312 (UTC) FILETIME=[0B875C80:01C5B7F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There's something else wrong too ... make rebuilds everything every
>time on IA64 now, rather than just the things that have changed (when
>compiling with -O)

I've added a "sleep 2" to the arch/ia64/Makefile ... and all my
non-deterministic problems appear to have gone away.

I don't seem this re-build everything problem.  I just tried
a "touch arch/ia64/kernel/efi.c ; make" and it only recompiled
that one file.  That's with the "sleep" in the Makefile, but I
can't imagine it affects this case.

Can you give more details on what you did?

-Tony
