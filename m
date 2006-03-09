Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWCIEsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWCIEsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWCIEsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:48:08 -0500
Received: from ozlabs.org ([203.10.76.45]:50103 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750796AbWCIEsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:48:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.45681.476222.143773@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 15:43:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
In-Reply-To: <200603082034.00238.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
	<17423.32792.500628.226831@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0603081716400.32577@g5.osdl.org>
	<200603082034.00238.jbarnes@virtuousgeek.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes writes:

> So ultimately mmiowb() is the only thing drivers really have to care 
> about on Altix (assuming they do DMA mapping correctly), and the rules 
> for that are fairly simple.  Then they can additionally use 
> read_relaxed() to optimize performance a bit (quite a bit on big 
> systems).

If I can be sure that all the drivers we care about on PPC use mmiowb
correctly, I can reduce or eliminate the barrier in write*, which
would be nice.

Which drivers have been audited to make sure they use mmiowb
correctly?  In particular, has the USB driver been audited?

Paul.
