Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285023AbRLFHV5>; Thu, 6 Dec 2001 02:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285027AbRLFHVr>; Thu, 6 Dec 2001 02:21:47 -0500
Received: from zok.sgi.com ([204.94.215.101]:25480 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S285023AbRLFHVi>;
	Thu, 6 Dec 2001 02:21:38 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas 
In-Reply-To: Your message of "Thu, 06 Dec 2001 09:09:35 +1100."
             <E16BkER-0006J0-00@wagner> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Dec 2001 18:21:25 +1100
Message-ID: <12352.1007623285@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2001 09:09:35 +1100, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>The following patch implements convenient per-cpu areas:

Did you look at PERCPU_ADDR in ia64?  Much (all?) of the per cpu data
is in struct cpuinfo_ia64 which is at the same virtual address on all
cpus but with different physical addresses on each cpu.  Let the mmu do
the work.  S390 does a similar trick, using the Prefixed Save Area
(PSA) which is virtual 0 but different physical addresses on each cpu.

