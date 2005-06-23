Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVFWJYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVFWJYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 05:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVFWJXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 05:23:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262613AbVFWJU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 05:20:26 -0400
Date: Thu, 23 Jun 2005 02:20:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DEBUG_PAGEALLOC & SMP?
Message-Id: <20050623022000.094169d4.akpm@osdl.org>
In-Reply-To: <20050623090936.GA28112@elte.hu>
References: <20050623090936.GA28112@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> is this a known problem?

Nope.

>  I'm getting an oom-kill and a stuck boot with 
>  SMP & PAGEALLOC enabled. The UP kernel boots fine.

Strange, something gobbled all of your ZONE_DMA.  0xd1 is
GFP_KERNEL|GFP_DMA, so perhaps something has gone mad in the bouncing code.

The oom-killer is supposed to do a dump_stack(), but it looks like that
patch got lost.

