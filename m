Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWIUU1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWIUU1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 16:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWIUU1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 16:27:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:28255 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1751543AbWIUU1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 16:27:22 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,196,1157353200"; 
   d="scan'208"; a="132185003:sNHT393039290"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zach Brown'" <zach.brown@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "'Suparna Bhattacharya'" <suparna@in.ibm.com>,
       <linux-kernel@vger.kernel.org>, "linux-aio" <linux-aio@kvack.org>
Subject: RE: [patch] clean up unused kiocb variables
Date: Thu, 21 Sep 2006 13:26:20 -0700
Message-ID: <000101c6ddbc$334248d0$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcbdtODucUrlwQboQJijMzNglaA2WAABspeg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <4512E910.6000308@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote on Thursday, September 21, 2006 12:34 PM
> Chen, Kenneth W wrote:
> > Any reason why we keep these two variables around for kiocb structure?
> 
> If there is a good one I've forgotten it.
> 
> > They are not used anywhere.
> 
> Indeed.


Let's remove them.  We can always add them back if there is a need.


> The ki_retried users all seem pretty questionable, too.  How about
> removing all that stuff?

Suparna wanted them around for debug purpose at one point.  I don't know
whether that is still the case right now.  At least I can wrap it around
with #if DEBUG.

- Ken
