Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbVG2RdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVG2RdJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVG2Ram
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:30:42 -0400
Received: from fmr23.intel.com ([143.183.121.15]:25314 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262641AbVG2RaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:30:20 -0400
Message-Id: <200507291730.j6THUCg15426@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
Date: Fri, 29 Jul 2005 10:30:12 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWUMG5fxrtMbb81SUyodAUzpB3O2gAMZbcQ
In-Reply-To: <20050729112616.GA24965@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Friday, July 29, 2005 4:26 AM
> * Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> > To demonstrate the problem, we turned off these two flags in the cpu 
> > sd domain and measured a stunning 2.15% performance gain!  And 
> > deleting all the code in the try_to_wake_up() pertain to load 
> > balancing gives us another 0.2% gain.
> 
> another thing: do you have a HT-capable ia64 CPU, and do you have 
> CONFIG_SCHED_SMT turned on? If yes then could you try to turn off 
> SD_WAKE_IDLE too, i found it to bring further performance improvements 
> in certain workloads.

The scheduler experiments done so far are on non-SMT CPU (Madison processor).
We have another db setup with multi-thread capable ia64 cpu (montecito, and to
be precise, it is SOEMT capable).  We are just about to do scheduler experiments
on that setup.


