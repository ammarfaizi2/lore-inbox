Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVBVSIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVBVSIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 13:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVBVSHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 13:07:38 -0500
Received: from fmr13.intel.com ([192.55.52.67]:710 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261266AbVBVSHU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 13:07:20 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch -mm series] ia64 specific /dev/mem handlers
Date: Tue, 22 Feb 2005 10:05:42 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F02F17D6A@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch -mm series] ia64 specific /dev/mem handlers
Thread-Index: AcUZB053vQYiJq82RFiI2L+bCIx14wAAPM5Q
From: "Luck, Tony" <tony.luck@intel.com>
To: "Jes Sorensen" <jes@wildopensource.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "Matthew Wilcox" <matthew@wil.cx>
X-OriginalArrivalTime: 22 Feb 2005 18:05:43.0999 (UTC) FILETIME=[2076E4F0:01C51909]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Feb 22, 2005 at 09:41:04AM -0500, Jes Sorensen wrote:
>> >> + if (page->flags & PG_uncached)
>> 
>> Andrew> dude.  That ain't gonna work ;)
>> 
>> Pardon my lack of clue, but why not?
>
>I think you're supposed to always use test_bit() to check page flags

You defined PG_uncached as "20" ... so either:

	if (page->flags & (1<<PG_uncached))

or (much better) to use:

	test_bit(PG_uncached, &page->flags).

-Tony
