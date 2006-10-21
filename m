Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992782AbWJUB3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992782AbWJUB3j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 21:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992781AbWJUB3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 21:29:39 -0400
Received: from ozlabs.org ([203.10.76.45]:33502 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S2992775AbWJUB3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 21:29:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17721.30698.868001.739660@cargo.ozlabs.ibm.com>
Date: Sat, 21 Oct 2006 11:29:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, David Miller <davem@davemloft.net>,
       nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com,
       James.Bottomley@SteelEye.com
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
In-Reply-To: <Pine.LNX.4.64.0610201733490.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org>
	<20061020214916.GA27810@linux-mips.org>
	<Pine.LNX.4.64.0610201500040.3962@g5.osdl.org>
	<20061020.152247.111203913.davem@davemloft.net>
	<20061020225118.GA30965@linux-mips.org>
	<Pine.LNX.4.64.0610201625190.3962@g5.osdl.org>
	<20061021000609.GA32701@linux-mips.org>
	<Pine.LNX.4.64.0610201733490.3962@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> I think (but may be mistaken) that ARM _does_ have pure virtual caches 
> with a process ID, but people have always ended up flushing them at 
> context switch simply because it just causes too much trouble.
> 
> Sparc? VIPT too? Davem?

There is one PowerPC embedded chip family, the PPC440, which has a
virtual i-cache with a process ID tag.  The d-cache is sane though.
Of course, the i-cache being readonly means we avoid the nastier
issues.

Paul.
