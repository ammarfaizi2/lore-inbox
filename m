Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbUKJKqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUKJKqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 05:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUKJKqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 05:46:14 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:34557 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261677AbUKJKqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 05:46:10 -0500
Date: Wed, 10 Nov 2004 16:19:14 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
Message-ID: <20041110104914.GA3825@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20041109130407.6d7faf10.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109130407.6d7faf10.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello.
> 

Hi,

> With kprobes enabled, vm86 doesn't feel
> good. The problem is that kprobes steal
> the interrupts (mainly int3 I think) from
> it for no good reason.

If the int3 is not registered through kprobes,
kprobes handler does not handle it and it falls through the
normal int3 handler AFAIK.
Could you please provide a test case to show that kprobes 
steals the interrupts.

Thanks
Prasanna

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
