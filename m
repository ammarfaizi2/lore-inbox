Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWB1EBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWB1EBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 23:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbWB1EBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 23:01:52 -0500
Received: from ozlabs.org ([203.10.76.45]:30135 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751810AbWB1EBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 23:01:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17411.51998.642468.642351@cargo.ozlabs.ibm.com>
Date: Tue, 28 Feb 2006 15:01:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: marcelo.tosatti@cyclades.com, ppc64-dev <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Signal hadnling fix for 2.4
In-Reply-To: <20060227160337.65610906.sfr@canb.auug.org.au>
References: <20060227160337.65610906.sfr@canb.auug.org.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell writes:

> While investigating a bug report about a 64bit application that crashed in
> malloc, Paul Mackerras noticed that sys_rt_sigreturn's return value was
> "int".  It needs to be "long" or else the return value of a syscall that
> is interrupted by a signal will be truncated to 32 bits and then sign
> extended.  This causes .e.g mmap's return value to be corrupted if it is
> returning an address above 2^31 (which is what caused a SEGV in malloc).
> This problem obviously only affects 64 bit processes.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Paul Mackerras <paulus@samba.org>
