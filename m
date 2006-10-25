Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161382AbWJYUoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161382AbWJYUoJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161383AbWJYUoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:44:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47056
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161382AbWJYUoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:44:06 -0400
Date: Wed, 25 Oct 2006 13:43:54 -0700 (PDT)
Message-Id: <20061025.134354.92582918.davem@davemloft.net>
To: supriyak@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Incorrect order of last two arguments of ptrace for requests
 PPC_PTRACE_GETREGS, SETREGS, GETFPREGS, SETFPREGS
From: David Miller <davem@davemloft.net>
In-Reply-To: <453F421A.6070507@in.ibm.com>
References: <453F421A.6070507@in.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: supriya kannery <supriyak@in.ibm.com>
Date: Wed, 25 Oct 2006 16:23:14 +0530

> If we exchange the last two arguments like,
> 
>  ptrace (PPC_PTRACE_GETREGS, pid, &reg[0], 0);
> 
> it works!

Please make sure that programs, such as gdb, aren't using the reversed
argument order.  If they are, you cannot "fix" this as it will break
all such applictions.
