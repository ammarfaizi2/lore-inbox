Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267966AbUHKGhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267966AbUHKGhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 02:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267964AbUHKGhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 02:37:07 -0400
Received: from fmr06.intel.com ([134.134.136.7]:41950 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267963AbUHKGgz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 02:36:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Hugetlb demanding paging for -mm tree
Date: Tue, 10 Aug 2004 23:36:10 -0700
Message-ID: <01EF044AAEE12F4BAAD955CB750649430205DE92@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hugetlb demanding paging for -mm tree
Thread-Index: AcR/VQtfC7Hsv+suSWKB+R6c+Ue2JwAFswGA
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Hirokazu Takahashi" <taka@valinux.co.jp>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 11 Aug 2004 06:36:12.0981 (UTC) FILETIME=[7EDD4650:01C47F6D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <> wrote on Tuesday, August 10, 2004 5:45 PM:

> William Lee Irwin III <mailto:wli@holomorphy.com> wrote on Tuesday,
>>> Could you rephrase that? I'm having trouble figuring out what you
>>> meant.
> 
> On Tue, Aug 10, 2004 at 05:28:27PM -0700, Seth, Rohit wrote:
>> I was thinking that we only need to worry about the d-cache
>> coherency at the time of hugepage fault.  But that is not a safe
>> assumption.  You are right that we will need update_mmu_cache in the
>> hugetlb page fault path. Though I'm wondering if we can hide this
>> update_mmu_cache fucntionality behind the arch specific set_huge_pte
>> function in the demand paging patch for hugepage.  If so then we may
>> not need to make any changes in the existing update_mmu_cache API.
> 
> Most arches seem to be okay with the API, but it may be more
> useful/etc. to e.g. explicitly pass the page size, particularly when
> constant folding is possible.
> 
> 

Are you working on the patch to provide this updated API for
update_mmu_cache.

