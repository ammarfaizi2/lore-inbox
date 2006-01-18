Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWARIrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWARIrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWARIrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:47:09 -0500
Received: from fmr20.intel.com ([134.134.136.19]:9406 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030193AbWARIrI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:47:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: hugetlb bug
Date: Wed, 18 Jan 2006 16:46:34 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E840483E8D4@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: hugetlb bug
Thread-Index: AcYcCvoWXG33z6kYTnmsPggyzhOoFQAAFrCQ
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "William Lee Irwin III" <wli@holomorphy.com>,
       "HuaFeijun" <hua.feijun@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Jan 2006 08:46:35.0703 (UTC) FILETIME=[B070AC70:01C61C0B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of William Lee Irwin III
>>Sent: 2006Äê1ÔÂ18ÈÕ 16:37
>>To: HuaFeijun
>>Cc: linux-kernel@vger.kernel.org
>>Subject: Re: hugetlb bug
>>
>>On Wed, Jan 18, 2006 at 04:00:03PM +0800, HuaFeijun wrote:
>>> Is it kernel bug? The code works normally on ia64 machine,howerver, on
>>> EM64T,it fails tot work.
>>> The function call of shmat will change /proc/meminfo;and  the shmdt
>>> can't restore it to original content.  How to restore it to original
>>> stauts?Thanks.
>>> Is it kernel bug? The code works normally on ia64 machine,howerver,
>>> on EM64T,it fails tot work. The function call of shmat will change
>>> /proc/meminfo file's content;and  the shmdt can't restore the file's
>>> content.  How to restore it to original stauts?Thanks.
Did you check ipc? Command 'ipcs -a" could show all shared memory. I guess you app doesn't call shmctl(..., IPC_RMID, ...) after shmdt. Use ipcrm to release them manually.

