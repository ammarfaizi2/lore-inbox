Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUEKShP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUEKShP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 14:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUEKShP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 14:37:15 -0400
Received: from fmr06.intel.com ([134.134.136.7]:35023 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263147AbUEKShJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 14:37:09 -0400
Message-ID: <00c001c43786$f1805000$ff0da8c0@amr.corp.intel.com>
From: "Geoff Gustafson" <geoff@linux.jf.intel.com>
To: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Cc: "Ken Chen" <kenneth.w.chen@intel.com>
References: <409FFF3B.3090506@linux.intel.com> <20040511004551.7c7af44d.akpm@osdl.org>
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Date: Tue, 11 May 2004 11:36:58 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Geoff Gustafson <geoff@linux.jf.intel.com> wrote:
>> 
>> I started this patch based on profiling an enterprise database
>>  application on a 32p IA64 NUMA machine, where del_timer_sync was
>>  one of the top few functions taking CPU time in the kernel.
> 
> Do you know where it's being called from?

OK, the main sources were:

sys_semtimedop() -> schedule_timeout()

sys_io_getevents() -> read_events() -> clear_timeout()

- Geoff

