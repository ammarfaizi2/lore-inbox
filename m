Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTIKO3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbTIKO3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:29:12 -0400
Received: from ns.suse.de ([195.135.220.2]:36762 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261249AbTIKO3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:29:08 -0400
Date: Thu, 11 Sep 2003 16:29:03 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Cc: torvalds@osdl.org, richard.brunner@amd.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-Id: <20030911162903.669f16d4.ak@suse.de>
In-Reply-To: <20030911141451.GA20434@redhat.com>
References: <20030911012708.GD3134@wotan.suse.de>
	<Pine.LNX.4.44.0309110650390.28410-100000@home.osdl.org>
	<20030911160108.5678113b.ak@suse.de>
	<20030911141451.GA20434@redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 15:14:51 +0100
Dave Jones <davej@redhat.com> wrote:

> On Thu, Sep 11, 2003 at 04:01:08PM +0200, Andi Kleen wrote:
> 
>  > > What's wrong with the current status quo that just says "Athlon prefetch
>  > > is broken"?
>  > It doesn't fix user space for once.
> 
> And for another, it cripples the earlier athlons which don't have this
> errata. Andi's fix at least makes prefetch work again on those boxes.
> It's also arguable that prefetch() helps the older K7's more than the
> affected ones.

All Athlons have this Errata. I can trigger it on an old
900Mhz pre XP Athlon too. You just have to use 3dnow prefetch
instead of SSE prefetch.

BTW the older Athlons currently don't use prefetch because the alternative
patcher does not handle 3dnow style prefetch.

-Andi
