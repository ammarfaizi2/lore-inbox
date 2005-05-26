Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVEZWmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVEZWmV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVEZWkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:40:40 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37858
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261849AbVEZWhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:37:18 -0400
Date: Thu, 26 May 2005 15:37:13 -0700 (PDT)
Message-Id: <20050526.153713.95060123.davem@davemloft.net>
To: roland@redhat.com
Cc: akpm@osdl.org, torvalds@osdl.org, mtk-lkml@gmx.net,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: waitid() fails with EINVAL for SA_RESTART signals
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200505262222.j4QMMHWe010741@magilla.sf.frob.com>
References: <24601.1116404447@www71.gmx.net>
	<200505262222.j4QMMHWe010741@magilla.sf.frob.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland McGrath <roland@redhat.com>
Date: Thu, 26 May 2005 15:22:17 -0700

> Other machines are subject to the same risk and should have a
> prevent_tail_call definition too.  The asm-i386/linkage.h version probably
> works fine for every machine.  It might as well be generic, I'd say.

Sparc, for one, doesn't need it.  We pass the pt_regs in via a pointer
to the trap level stack frame which won't be released by a tail-call
in C code.
