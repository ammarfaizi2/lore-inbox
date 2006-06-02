Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWFBHTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWFBHTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWFBHTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:19:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53379 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751250AbWFBHTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:19:05 -0400
Date: Fri, 2 Jun 2006 00:22:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: jbeulich@novell.com, jeff@garzik.org, htejun@gmail.com,
       reuben-lkml@reub.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060602002252.aaa5e4e3.akpm@osdl.org>
In-Reply-To: <20060602070948.GB9721@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<447EB4AD.4060101@reub.net>
	<20060601025632.6683041e.akpm@osdl.org>
	<447EBD46.7010607@reub.net>
	<20060601103315.GA1865@elte.hu>
	<20060601105300.GA2985@elte.hu>
	<447EF7A8.76E4.0078.0@novell.com>
	<447FFCAC.76E4.0078.0@novell.com>
	<20060602070948.GB9721@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006 09:09:48 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> In all other cases (if we go outside of the stack page(s)) we _must_ 
> fall back to the dump 'scan the stack pages for interesting entries' 
> method, to get the information out! "Uh oh the unwind info somehow got 
> corrupted, sorry" is not enough to debug a kernel bug.

Also, it might be worth doing a two-pass thing.  Pass 1 doesn't print
anything - it just figures out whether pass2 will succeed.  If not, fall
back without printing anything.


