Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVCCGgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVCCGgB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVCCGfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:35:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:59348 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261550AbVCCGdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:33:19 -0500
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "David S. Miller" <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>, clameter@sgi.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Anton Blanchard <anton@samba.org>
In-Reply-To: <42274727.2070200@yahoo.com.au>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
	 <20050302174507.7991af94.akpm@osdl.org>
	 <Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
	 <20050302185508.4cd2f618.akpm@osdl.org>
	 <Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
	 <20050302201425.2b994195.akpm@osdl.org>
	 <16934.39386.686708.768378@cargo.ozlabs.ibm.com>
	 <20050302213831.7e6449eb.davem@davemloft.net>
	 <1109829248.5679.178.camel@gaston>  <42274727.2070200@yahoo.com.au>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 17:30:28 +1100
Message-Id: <1109831428.5680.187.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 04:19 +1100, Nick Piggin wrote:

> You don't want to do that for all architectures, as I said earlier.
> eg. i386 can concurrently set the dirty bit with the MMU (which won't
> honour the lock).
> 
> So you then need an atomic lock, atomic pte operations, and atomic
> unlock where previously you had only the atomic pte operation. This is
> disastrous for performance.

Of course, but I was answering to David about sparc64 which uses
software TLB load :)

Ben.


