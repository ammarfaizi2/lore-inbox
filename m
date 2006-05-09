Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWEJCPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWEJCPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWEJCPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:15:50 -0400
Received: from silver.veritas.com ([143.127.12.111]:32113 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932397AbWEJCPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:15:49 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,107,1146466800"; 
   d="scan'208"; a="38018681:sNHT23564072"
Date: Tue, 9 May 2006 20:22:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Brian Twichell <tbrian@us.ibm.com>
cc: Dave McCracken <dmccr@us.ibm.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2][RFC] New version of shared page tables
In-Reply-To: <445FA0CA.4010008@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0605092012170.8037@blonde.wat.veritas.com>
References: <1146671004.24422.20.camel@wildcat.int.mccr.org>
 <Pine.LNX.4.64.0605031650190.3057@blonde.wat.veritas.com>
 <57DF992082E5BD7D36C9D441@[10.1.1.4]> <Pine.LNX.4.64.0605061620560.5462@blonde.wat.veritas.com>
 <445FA0CA.4010008@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 May 2006 02:15:49.0416 (UTC) FILETIME=[A7A13280:01C673D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2006, Brian Twichell wrote:
> 
> If we had to choose between pagetable sharing for small pages and hugepages,
> we would be in favor of retaining pagetable sharing for small pages.  That is
> where the discernable benefit is for customers that run with "out-of-the-box"
> settings.  Also, there is still some benefit there on x86-64 for customers
> that use hugepages for the bufferpools.

Thanks for the further info, Brian.  Okay, the hugepage end of it does
add a different kind of complexity, in an area already complex from the
different arch implementations.  If you've found that a significant part
of the hugepage test improvment is actually due to the smallpage changes,
let's turn around what I said, and suggest Dave concentrate on getting the
smallpage changes right, putting the hugepage part of it on the backburner
at least for now (or if he's particularly keen still to present it, as 3/3).

Hugh
