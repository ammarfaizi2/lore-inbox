Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVEZSYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVEZSYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVEZSYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:24:52 -0400
Received: from fmr19.intel.com ([134.134.136.18]:56290 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261682AbVEZSYo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:24:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] Kprobes ia64 qp fix
Date: Thu, 26 May 2005 11:23:44 -0700
Message-ID: <032EB457B9DBC540BFB1B7B519C78B0E073AE2CC@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] Kprobes ia64 qp fix
thread-index: AcViH2GXn4xndsU6SbmV0M3J6vyuqQAAFO0w
From: "Lynch, Rusty" <rusty.lynch@intel.com>
To: <davidm@hpl.hp.com>
Cc: <akpm@osdl.org>, "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 26 May 2005 18:23:25.0001 (UTC) FILETIME=[0149B390:01C56220]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> On Thu, 26 May 2005 10:51:45 -0700, Rusty Lynch
><rusty.lynch@intel.com> said:
>
>  Rusty> The following patch is for the 2.6.12-rc5-mm1 + my previous
>  Rusty> "Kprobes ia64 cleanup" patch that fixes a bug where a kprobe
still
>  Rusty> fires when the instruction is predicated off.  So given the
p6=0,
>  Rusty> and we have an instruction like:
>
>  Rusty> (p6) move loc1=0
>
>  Rusty> we should not be triggering the kprobe.  This is handled by
>  Rusty> carrying over the qp section of the original instruction into
>  Rusty> the break instruction.
>
>What about:
>
>	(p6) cmp.eq.unc p9,p10=rX,rY
>
>would the code handle that right?  Similary, you may want to check for
>the correct handling of instructions that cannot be predicated (such
>as "cover").
>
>	--david

Thanks, I need to look into this one.  Let me update my test to cover
both of these cases and then take another look at our logic.

    --rusty
