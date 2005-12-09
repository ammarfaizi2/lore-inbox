Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVLISho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVLISho (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVLISho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:37:44 -0500
Received: from fmr15.intel.com ([192.55.52.69]:63378 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S932275AbVLISho convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:37:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [discuss] Re: [patch 3/3] add x86-64 support for memory hot-add II
Date: Fri, 9 Dec 2005 10:36:53 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00BD331EE@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] Re: [patch 3/3] add x86-64 support for memory hot-add II
Thread-Index: AcX86OO8PgmZ7iT0R++cnGggy7PmRwABkqYA
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Andi Kleen" <ak@suse.de>, "Andi Kleen" <ak@muc.de>
Cc: "Matt Tolentino" <metolent@cs.vt.edu>, <akpm@osdl.org>,
       <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Dec 2005 18:36:56.0914 (UTC) FILETIME=[889A8B20:01C5FCEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <mailto:ak@suse.de> wrote:
>> In general SRAT has a hotplug memory bit so it's possible
>> to predict how much memory there will be in advance. Since
>> the overhead of the kernel page tables should be very
>> low I would prefer if you just used instead.
>> 
>> (i.e. instead of extending the kernel mapping preallocate
>> the direct mapping and just clear the P bits)
>> 
>> That should be much simpler.
> 
> Looking at it again - accessing SRAT currently relies on the
> direct mapping already. Untangling that would be possible,
> but require an bt_ioremap which would also add lots of code.
> 
> Ok I retract that objection. I guess your way is better
> for now.

Thanks for considering this Andi.  
 
> In addition to the __cpuinit comment
> 
> +if (after_bootmem) spin_unlock(&init_mm.page_table_lock);
> 
> Conditional locking is evil. spinlocking in the boot
> case should just work too I think.
> 
> The EXPORTs should be probably EXPORT_SYMBOL_GPL.
> 
> With these changes it would look ok for me.

Excellent points.  Thanks for the review and suggestions.  I'm
testing a revised patch now and will repost in a bit.  

matt
