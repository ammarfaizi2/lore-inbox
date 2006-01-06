Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbWAFRVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbWAFRVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWAFRUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:20:04 -0500
Received: from fmr23.intel.com ([143.183.121.15]:5316 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932686AbWAFRUA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:20:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] ia64: change defconfig to NR_CPUS==1024
Date: Fri, 6 Jan 2006 09:19:28 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F055A7AFB@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ia64: change defconfig to NR_CPUS==1024
Thread-Index: AcYSnQDY8o1DS5mGTsSopAjjLnXqOwAR5wlA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Arjan van de Ven" <arjan@infradead.org>, <hawkes@sgi.com>
Cc: "Tony Luck" <tony.luck@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Jack Steiner" <steiner@sgi.com>, "Dan Higgins" <djh@sgi.com>,
       "John Hesterberg" <jh@sgi.com>, "Greg Edwards" <edwardsg@sgi.com>
X-OriginalArrivalTime: 06 Jan 2006 17:19:27.0389 (UTC) FILETIME=[58D654D0:01C612E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Increase the generic ia64 config from its current max of 512 CPUs to a
>> new max of 1024 CPUs.
>
>I wonder why this would be seen as a sane thing...
>Very few people have 1024 cpus, and the ones that do sure would know how
>to set 1024 in their kernel config. In fact I would argue to lower it. I
>can see the point of keeping it over 64, to give the
>more-cpus-than-a-long code more testing, but 512 is too high already..
>most people who have ia64 will not have 512 cpus.

Would it be impossibly hard to make the >64 cpus case (when the code
switches from a single word to an array) be dependent on a boot-time
variable?  If we could, then the defconfig could just say 128, and
users of monster machines would just boot with "maxcpus=4096" to increase
the size of the bitmask arrays.

-Tony
