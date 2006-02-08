Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbWBHShH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbWBHShH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWBHShH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:37:07 -0500
Received: from fmr18.intel.com ([134.134.136.17]:54214 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030445AbWBHShE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:37:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6 patch] let IA64_GENERIC select more stuff
Date: Wed, 8 Feb 2006 10:35:57 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05A6DEE7@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] let IA64_GENERIC select more stuff
Thread-Index: AcYstWF/Hbc/mNZuQfOk3ANjY2icgAAJsR5w
From: "Luck, Tony" <tony.luck@intel.com>
To: "Jes Sorensen" <jes@sgi.com>, "Adrian Bunk" <bunk@stusta.de>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, "Keith Owens" <kaos@sgi.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Feb 2006 18:35:58.0531 (UTC) FILETIME=[8100C130:01C62CDE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian> Is this OK for you?

Jes> Not really, it helps a bit by selecting some things we know we need
Jes> for all GENERIC builds. True we can't make it bullet proof, but whats
Jes> there is better than removing it.

Which I think sums up why this is so contentious.  There is no right answer
here as the purpose of the GENERIC entry is rather vague and has been
interpreted differently by different people.  Mostly it is a convenience
entry that auto-selects a bunch of other config options, but there isn't
a single answer to what it should select, as different people have different
goals, so what might be convenient for one person would be a pain for
someone else.

The current set looks close ... perhaps PCI should be added as it isn't
likely to inconvenience anyone, but SMP is a lot further into murky territory
(some distributors like to use a UP kernel for installation ... so they
want a "generic" kernel, but don't need to worry about SMP ... there are few
places where SMP would be advantageous during install).

-Tony
