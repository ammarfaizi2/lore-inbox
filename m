Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268225AbUJSBNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268225AbUJSBNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 21:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbUJSBKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 21:10:54 -0400
Received: from fmr05.intel.com ([134.134.136.6]:63380 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S268248AbUJSBKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:10:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Subject: RE: function hugetlb_get_unmapped_area failed to find an unmapped area while unmapped area is huge
Date: Tue, 19 Oct 2004 09:10:30 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E849CC872@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: function hugetlb_get_unmapped_area failed to find an unmapped area while unmapped area is huge
Thread-Index: AcS1eD9tTxAvvIUuTnOVteb086W4tgAAA7ag
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-OriginalArrivalTime: 19 Oct 2004 01:10:31.0263 (UTC) FILETIME=[6D987EF0:01C4B578]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add subject.

>>-----Original Message-----
>>From: Zhang, Yanmin
>>Sent: 2004年10月19日 9:09
>>To: linux-kernel@vger.kernel.org
>>Cc: Chen, Kenneth W
>>Subject:
>>
>>In base kernel 2.6.9-rc4, function hugetlb_get_unmapped_area failed to find
>>an unmapped area while unmapped area is huge. That's because
>>hugetlb_get_unmapped_area just searches forward from mm->free_area_cache. If
>>reaching TASK_SIZE, it does not go back to TASK_UNMAPPED_BASE, just returns
>>-ENOMEM.
>>The attachment is a simple case to trigger it on IA32 machine.
>>
>>The other attachment is the patch to fix it.
>>1) Add a specific hugetlb_get_unmapped_area on i386.
>>2) Generic hugetlb_get_unmapped_area is also fixed.
>>
>>Signed-off-by: Zhang Yanmin	<yanmin.zhang@intel.com>

