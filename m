Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVG2IdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVG2IdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVG2IdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:33:13 -0400
Received: from fmr21.intel.com ([143.183.121.13]:16588 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262478AbVG2Ic3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:32:29 -0400
Message-Id: <200507290830.j6T8Ugg08348@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "Keith Owens" <kaos@ocs.com.au>, <David.Mosberger@acm.org>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: Add prefetch switch stack hook in scheduler function
Date: Fri, 29 Jul 2005 01:30:41 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWUDCtGsVYVHTreSke1e7q3coGOkAAC1GiQ
In-Reply-To: <20050729070702.GA3327@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Friday, July 29, 2005 12:07 AM
> the patch below unrolls the prefetch_range() loop manually, for up to 5 
> cachelines prefetched. This patch, ontop of the 4 previous patches, 
> should generate similar code to the assembly code in your original 
> patch. The full patch-series is:

It generate slight different code because previous patch asks for a little
over 5 cache lines worth of bytes and it always go to the for loop.

