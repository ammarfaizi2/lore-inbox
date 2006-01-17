Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWAQXbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWAQXbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWAQXbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:31:51 -0500
Received: from fmr13.intel.com ([192.55.52.67]:12941 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932238AbWAQXbu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:31:50 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Boot problem with [PATCH] x86_64: Allow kernel page tables upto the end of memory
Date: Tue, 17 Jan 2006 15:31:44 -0800
Message-ID: <2BD5725B505DC54E8CDCF251DC8A2E7E09599C6C@fmsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Boot problem with [PATCH] x86_64: Allow kernel page tables upto the end of memory
Thread-Index: AcYbrj9Jb+pNjYiVQBWEOzMTP86VcwAD3BhQ
From: "Chen, Tim C" <tim.c.chen@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Jan 2006 23:31:45.0497 (UTC) FILETIME=[2DEE5C90:01C61BBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 17 January 2006 22:32, Tim Chen wrote:
>> Hi Andi,
>> 
>> With this patch in 2.6.15-git12,
>> 
>>
(http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a
>> =com mit;h=6c5acd160a10c76e8debf4f8fa8256d7c914f290), I found that
>> kernel could  no longer boot when I include "mem=1G" boot option on a
>> dual Xeon machine  that has more than 4G of memory.  The machine
>> boots normally without  "mem=1G" specified or when the patch is
>> backed out. I have included the boot log of the failed boot and the
>> normal boot for  your reference.  The table_start was relocated from
>> 0x8000 to 0x100000000  with the patch applied.
> 
> Still don't understand why 4GB doesn't work with mem=, but git13 will
> not relocate the tables there anymore and shouldn't have this
> problem.  
> 
> -Andi

Thanks.  I have verified that git13 code no longer have this issue.

Tim
