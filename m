Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVHREHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVHREHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 00:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVHREHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 00:07:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58327 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932117AbVHREHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 00:07:18 -0400
Date: Wed, 17 Aug 2005 21:05:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: riel@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH/RFT 4/5] CLOCK-Pro page replacement
Message-Id: <20050817210532.54ace193.akpm@osdl.org>
In-Reply-To: <20050817.194822.92757361.davem@davemloft.net>
References: <20050810200943.809832000@jumble.boston.redhat.com>
	<20050810.133125.08323684.davem@davemloft.net>
	<20050817173818.098462b5.akpm@osdl.org>
	<20050817.194822.92757361.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> From: Andrew Morton <akpm@osdl.org>
> Date: Wed, 17 Aug 2005 17:38:18 -0700
> 
> > I'm prety sure we fixed that somehow.  But I forget how.
> 
> I wish you could remember :-)  I honestly don't think we did.
> The DEFINE_PER_CPU() definition still looks the same, and the
> way the .data.percpu section is layed out in the vmlinux.lds.S
> is still the same as well.

Argh, can't remember, can't find it with archive grep.  I just have a
mental note that it got fixed somehow.  Perhaps by uprevving the compiler
version?  We certainly have a ton of uninitialised DEFINE_PER_CPUs in there
nowadays and people's kernels aren't crashing.

Rusty, do you recall if/how we fixed the
DEFINE_PER_CPU-needs-explicit-initialisation thing?
