Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263296AbVCKAj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263296AbVCKAj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 19:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVCKAdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 19:33:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:43423 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261912AbVCKAbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 19:31:08 -0500
Date: Thu, 10 Mar 2005 16:30:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: re-inline sched functions
Message-Id: <20050310163056.64878c24.akpm@osdl.org>
In-Reply-To: <200503110024.j2B0OFg06087@unix-os.sc.intel.com>
References: <200503110024.j2B0OFg06087@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> This could be part of the unknown 2% performance regression with
> db transaction processing benchmark.
> 
> The four functions in the following patch use to be inline.  They
> are un-inlined since 2.6.7.
> 
> We measured that by re-inline them back on 2.6.9, it improves performance
> for db transaction processing benchmark, +0.2% (on real hardware :-)
> 
> The cost is certainly larger kernel size, cost 928 bytes on x86, and
> 2728 bytes on ia64.  But certainly worth the money for enterprise
> customer since they improve performance on enterprise workload.

Less that 1k on x86 versus >2k on ia64.  No wonder those things have such
big caches ;)

> ...
> Possible we can introduce them back?

OK by me.

