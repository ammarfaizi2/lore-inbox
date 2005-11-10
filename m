Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVKJXeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVKJXeQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVKJXeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:34:16 -0500
Received: from fmr22.intel.com ([143.183.121.14]:56705 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751232AbVKJXeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:34:16 -0500
Message-Id: <200511102334.jAANY1g21612@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@engr.sgi.com>,
       "Adam Litke" <agl@us.ibm.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: RE: [PATCH] dequeue a huge page near to this node
Date: Thu, 10 Nov 2005 15:34:01 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXmTkr5TNm40tnvSBKLwu4cLqYVsgAAMcsw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <Pine.LNX.4.62.0511101521180.16770@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, November 10, 2005 3:27 PM
> The following patch changes the dequeueing to select a huge page near
> the node executing instead of always beginning to check for free 
> nodes from node 0. This will result in a placement of the huge pages near
> the executing processor improving performance.
> 
> The existing implementation can place the huge pages far away from 
> the executing processor causing significant degradation of performance.
> The search starting from zero also means that the lower zones quickly 
> run out of memory. Selecting a huge page near the process distributed the 
> huge pages better.


Looks great!

- Ken

