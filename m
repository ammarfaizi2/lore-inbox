Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266961AbSKLVZR>; Tue, 12 Nov 2002 16:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266962AbSKLVZR>; Tue, 12 Nov 2002 16:25:17 -0500
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:9861 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S266961AbSKLVZR>; Tue, 12 Nov 2002 16:25:17 -0500
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200211122132.WAA03038@faui11.informatik.uni-erlangen.de>
Subject: Re: [PATCH] flush_cache_page while pte valid
To: manfred@colorfullife.com
Date: Tue, 12 Nov 2002 22:32:03 +0100 (MET)
Cc: linux-kernel@vger.kernel.org, uweigand@de.ibm.com
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

>The assumption for the dirty bit is that the i386 cpu are the only cpus 
>in the world (TM) that maintain the dirty bit in hardware

Not true; the s390 also has a dirty bit in hardware ;-)

To make things more interesting, the s390 dirty bit does not
reside in the pte, but in a storage key associated with the
*physical* page.  The bit is set on any access to the physical
page, whether through any virtual mapping, by direct access
with dynamic address translation switched off, or by an I/O
device moving data directly to main memory.

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
