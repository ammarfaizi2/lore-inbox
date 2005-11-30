Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbVK3SG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbVK3SG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 13:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbVK3SG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 13:06:56 -0500
Received: from petasus.ims.intel.com ([62.118.80.130]:55511 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S1751491AbVK3SG4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 13:06:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/1] elevator: indirect function calls reducing
Date: Wed, 30 Nov 2005 21:05:29 +0300
Message-ID: <6694B22B6436BC43B429958787E45498E7877C@mssmsx402nb>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] elevator: indirect function calls reducing
Thread-Index: AcX1zJQjS5c+1j7zTqSkGWtrU0lfkwACVFLQ
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>,
       "Arjan van de Ven" <arjan@infradead.org>
X-OriginalArrivalTime: 30 Nov 2005 18:05:33.0178 (UTC) FILETIME=[A8177DA0:01C5F5D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,
During that function calls 3 memory ridings are performed under
spin_lock and having cache miss/conflict problem;
and 2 only main memory ridings after patching.

In a source a[b][c][d](arg);
after patching number of memory ridings less by 1:
a[c][d](arg);
Do you agree with it?
Have you other explanation of performance degradation 2.6.9 -> 2.6.10?

Leonid


-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org] 
Sent: Wednesday, November 30, 2005 7:26 PM
To: Ananiev, Leonid I
Cc: linux-kernel@vger.kernel.org; axboe@suse.de
Subject: Re: [PATCH 1/1] elevator: indirect function calls reducing


this _still_ isn't an indirect function call reduction and people
have told you N times.  Please get your basics right first, to start
with the patch description.
