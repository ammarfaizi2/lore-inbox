Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUHBGAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUHBGAZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 02:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266275AbUHBGAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 02:00:25 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:57028 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S266274AbUHBGAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 02:00:23 -0400
Subject: Re: [PATCH] use for_each_cpu
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040801004708.6fa9f6f8.akpm@osdl.org>
References: <20040801060144.GI30253@krispykreme>
	 <20040731230859.138ba584.akpm@osdl.org>
	 <20040801072711.GJ30253@krispykreme>
	 <20040801004708.6fa9f6f8.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1091401715.24784.3.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 02 Aug 2004 15:59:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-01 at 17:47, Andrew Morton wrote:
> >  Is it worth adding complexity to the cpu
> > notifiers vs just using for_each_cpu?
> 
> yup ;) It's only six lines, and it follows the same pattern as is used in,
> say, page_alloc_cpu_notify().  Doing the same thing the same way in
> multiple places is to be preferred, yes?

Yes, and that way is "for_each_cpu".

Andrew, take his patch.  You know for_each_cpu is preferred over
for_each_online_cpu unless there's a good reason for the latter.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

