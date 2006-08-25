Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422868AbWHYPvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422868AbWHYPvf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422866AbWHYPvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:51:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:4811 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422860AbWHYPve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:51:34 -0400
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.64.0608250838410.9083@schroedinger.engr.sgi.com>
References: <20060824234430.6AC970F7@localhost.localdomain>
	 <Pine.LNX.4.64.0608250838410.9083@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 08:51:22 -0700
Message-Id: <1156521082.12011.182.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 08:42 -0700, Christoph Lameter wrote:
> I think this is a good thing to do. However, the patch as it is now is 
> difficult to review. Could you split the patch into multiple patches? One 
> patch that introduces the generic functionality and then do one patch 
> per arch? It would be best to sent the arch specific patches to the arch 
> mailing list or the arch maintainer for review.
> 
> You probably can get the generic piece into mm together with the first 
> arch specific patch (once the first arch has signed off) and then submit 
> further bits as the reviews get completed.

It _is_ too big.  However, I think doing 24 different architectures
separately would probably be a major pain, and never get done.  It would
also have to create some temporary Kconfig names (or give up the names
it uses now, which duplicate some arch code).

How about this: I'll split it up, one patch for each of the difficult
architectures: parisc, mips, sparc64, ia64, one patch for the 4k-only
page architectures, and we'll look at what's left?

-- Dave

