Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVDFLbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVDFLbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 07:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVDFLbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 07:31:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:63639 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262166AbVDFLb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:31:29 -0400
Date: Wed, 6 Apr 2005 04:30:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marty Ridgeway <mridge@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       ltp-announce@lists.sourceforge.net
Subject: Re: [ANNOUNCE] April Release of LTP now Available
Message-Id: <20050406043001.3f3d7c1c.akpm@osdl.org>
In-Reply-To: <OF98479217.2360E20E-ON85256FDA.00696BC9-86256FDA.00698E70@us.ibm.com>
References: <OF98479217.2360E20E-ON85256FDA.00696BC9-86256FDA.00698E70@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marty Ridgeway <mridge@us.ibm.com> wrote:
>
> The April release of LTP is now on SourceForge.
> 
>  LTP-20050405

It seems to have an x86ism in it which causes the compile to fail on ppc64:

socketcall01.c: In function `socketcall':
socketcall01.c:80: error: asm-specifier for variable `__sc_4' conflicts with asm clobber list




#ifndef _syscall2
#include <linux/unistd.h>
#endif

#include "test.h"
#include "usctest.h"

char *TCID = "socketcall01";                             /* Test program identifier.    */
#ifdef __NR_socketcall

_syscall2(int ,socketcall ,int ,call, unsigned long *, args);
