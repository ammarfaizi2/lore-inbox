Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751735AbVLGSkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbVLGSkR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbVLGSkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:40:16 -0500
Received: from fmr24.intel.com ([143.183.121.16]:45994 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751735AbVLGSkN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:40:13 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [RFC 1/3] Framework for accurate node based statistics 
Date: Wed, 7 Dec 2005 10:39:54 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F052359F9@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 1/3] Framework for accurate node based statistics 
Thread-Index: AcX7XAzPzDP2aXYaQV2LSJkCImLZ5QAAJecg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Christoph Lameter" <clameter@engr.sgi.com>, "Keith Owens" <kaos@sgi.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>, <linux-mm@kvack.org>,
       <linux-ia64@vger.kernel.org>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
X-OriginalArrivalTime: 07 Dec 2005 18:39:49.0026 (UTC) FILETIME=[9A5D4020:01C5FB5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> How big is that array going to get?  The total per cpu data area is
>> limited to 64K on IA64 and we already use at least 34K.
>
> Maximum around 1k nodes and I guess we may end up with 16 counters:
>
> 1024*16*8 = 131k ?

Ouch.

Can you live with a pointer to that monster block of space in the
per-cpu area?

Otherwise the next step up is a 256K per cpu area ... which I wouldn't
want to make the default (so we'll have another 2*X explosion in the
number of possible configs to test).

-Tony
