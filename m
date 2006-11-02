Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752760AbWKBJK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbWKBJK5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 04:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbWKBJK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 04:10:57 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:59324 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1752764AbWKBJKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 04:10:55 -0500
Subject: Re: [patch -mm] s390: pagefault_disable/enable build fix
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
In-Reply-To: <20061102090546.GA7131@osiris.boeblingen.de.ibm.com>
References: <20061101235407.a92f94a5.akpm@osdl.org>
	 <20061102090546.GA7131@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 10:11:51 +0100
Message-Id: <1162458711.27131.8.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 10:05 +0100, Heiko Carstens wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> arch/s390/lib/lib.a(uaccess_std.o)(.text+0x282): In function `futex_atomic_op':
> : undefined reference to `pagefault_disable'
> 
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
> 
> Looks like we want to replace all asm/uaccess.h with linux/uaccess.h...

Bah, I knew that misery was upon us:
 http://programming.kicks-ass.net/kernel-patches/mm_inatomic/

In particular:
http://programming.kicks-ass.net/kernel-patches/mm_inatomic/uaccess_asm_to_linux.patch

:-(

I'd just hoped that'd not be needed for these three patches...

