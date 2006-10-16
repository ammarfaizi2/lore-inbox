Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWJPOSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWJPOSI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWJPOSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:18:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19104 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932094AbWJPOSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:18:05 -0400
Subject: Re: Would SSI clustering extensions be of interest to
	kernelcommunity?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Constantine Gavrilov <constg@qlusters.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45339234.4050400@qlusters.com>
References: <45337FE3.8020201@qlusters.com>
	 <1161006841.24237.33.camel@localhost.localdomain>
	 <45339234.4050400@qlusters.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 15:44:50 +0100
Message-Id: <1161009890.24237.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-16 am 16:07 +0200, ysgrifennodd Constantine Gavrilov:
> SSI intrudes kernel in two places: a) IO system calls, b ) page fault
> code for shared memory pages.
> 
> a) IO system calls are "packed" and forwarded to the "home" node,
> where original syscall code is executed. 
> b) A hook is inserted into page fault code that brings shared memory
> pages from other nodes when necessary.
> 
> Apart from these two hooks, SSI code is a "standalone" kernel API
> add-on ("add", not "change").
> 
> Currently, we can do both "intrusions" from the kernel module. I
> assume that if we submit code, you will require a kernel patch that
> explicitly calls our hooks. 

Yep. Thats probably the most critical single thing to review.
> 
> Also, continuous SSI in-kernel support may require SSI changes in the
> following cases: a) new fields in task struct that reflect process
> state (may affect task migration), b) changes in the page fault
> mechanism (may effect SSI shared memory code that brings and
> invalidates pages), c) addition of new system calls (may require
> implementation of  SSI suspport for them).

SSI changes triggered from core changes are fairly expected I think
because you need to serialize new objects.
