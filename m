Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWCVMTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWCVMTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 07:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWCVMTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 07:19:31 -0500
Received: from ozlabs.org ([203.10.76.45]:19647 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750841AbWCVMTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 07:19:31 -0500
Date: Wed, 22 Mar 2006 23:17:47 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, mingo@elte.hu,
       akpm@osdl.org
Subject: Re: [PATCH] possible scheduler deadlock in 2.6.16
Message-ID: <20060322121747.GE30422@krispykreme>
References: <20060322104143.GC30422@krispykreme> <4421307F.8020300@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4421307F.8020300@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi Nick,

> You're right. I can't think of a better fix, although we've been trying
> to avoid adding cpu to the runqueue structure.
>
> I was going to suggest moving more work into wake_sleeping_dependent
> instead, but cores with 4 and more threads now make that less desirable
> I suppose.

My thoughts too. I wasnt sure if davem is planning to use the sibling
code for his niagara work, but locking us down to 2 siblings sounds like
a bad idea.

Anton
