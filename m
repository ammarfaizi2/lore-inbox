Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVG2Ipj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVG2Ipj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVG2InK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:43:10 -0400
Received: from fmr24.intel.com ([143.183.121.16]:48001 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262517AbVG2IlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:41:11 -0400
Message-Id: <200507290839.j6T8dqg08486@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "Keith Owens" <kaos@ocs.com.au>, <David.Mosberger@acm.org>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: Add prefetch switch stack hook in scheduler function
Date: Fri, 29 Jul 2005 01:39:51 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWUGJrxF6usCxT7Q/ej2UgrCO46wwAAB5gg
In-Reply-To: <20050729083558.GA7302@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Friday, July 29, 2005 1:36 AM
> * Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> > It generate slight different code because previous patch asks for a little
> > over 5 cache lines worth of bytes and it always go to the for loop.
> 
> ok - fix below. But i'm not that sure we want to unroll a 6-instruction 
> loop, and it's getting a bit ugly.

Yeah, I agree. We probably won't see a difference whether the loop is unrolled
or not.

