Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263209AbUDAWtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUDAWtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:49:07 -0500
Received: from faui10.informatik.uni-erlangen.de ([131.188.31.10]:16328 "EHLO
	faui10.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S263209AbUDAWtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 17:49:01 -0500
From: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Message-Id: <200404012248.AAA23951@faui1d.informatik.uni-erlangen.de>
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
To: Joe.Buck@synopsys.com (Joe Buck)
Date: Fri, 2 Apr 2004 00:48:55 +0200 (CEST)
Cc: ak@suse.de (Andi Kleen),
       weigand@i1.informatik.uni-erlangen.de (Ulrich Weigand), gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <20040401143908.B4619@synopsys.com> from "Joe Buck" at Apr 01, 2004 02:39:08 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Buck wrote:

> Case 2: make falsely thinks that the .c is younger than the .o.  It
> recompiles the .c file, even though it didn't have to.  Harmless.

*Not* harmless, in fact this is exactly what breaks my bootstrap.

Think about what happens when cc1 is 'harmlessly' rebuilt just
while in a parallel make that very same cc1 binary is used to
run a compile ...

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
