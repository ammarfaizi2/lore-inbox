Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbVLOC5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbVLOC5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVLOC5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:57:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21925 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965042AbVLOC5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:57:18 -0500
Date: Wed, 14 Dec 2005 18:56:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, bcrl@kvack.org, tony.luck@intel.com
Subject: Re: 2.6.15-rc5-mm2 can't boot on ia64 due to changing
 on_each_cpu().
Message-Id: <20051214185658.7a60aa07.akpm@osdl.org>
In-Reply-To: <20051215103344.241C.Y-GOTO@jp.fujitsu.com>
References: <20051215103344.241C.Y-GOTO@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
>
> When I removed following patch which is in 2.6.15-rc5-mm2,
>  which changes on_each_cpu() from static inline function to macro,
>  then there was no warning, and kernel could boot up.
>  So, I guess that gcc was not able to solve a bit messy cast
>  for calling function "local_flush_tlb_all()" due to its change.

Thanks.  I'll drop it.

I built and booted that kernel on my Tiger.  Odd.  I suspect there's
something very non-aggressive about my .config - this sort of thing has
happened before.
