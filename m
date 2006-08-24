Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWHXKfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWHXKfo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWHXKfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:35:44 -0400
Received: from [71.39.252.251] ([71.39.252.251]:11423 "EHLO
	neumann.snitselaar.org") by vger.kernel.org with ESMTP
	id S1751048AbWHXKfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:35:43 -0400
Date: Thu, 24 Aug 2006 03:35:29 -0700
From: Gerard J Snitselaar <snits@snitselaar.org>
To: Amnon Shiloh <amnons@cs.huji.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug report: mem_write
Message-ID: <20060824103529.GA19854@snitselaar.org>
References: <E1GGAWv-0001uP-Mu@lucifer.cs.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GGAWv-0001uP-Mu@lucifer.cs.huji.ac.il>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  0, Amnon Shiloh <amnons@cs.huji.ac.il> wrote:
> Hi,
> 
> Alright, I know that "mem_write" (fs/proc/base.c) is a "security hazard",
> but I need to use it anyway (as super-user only), and find it broken,
> somewhere between Linux-2.6.17 and Linux-2.6.18-rc4.
> 
> The point is that in the beginning of the routine, "copied" is set to 0,
> but it is no good because in lines 805 and 812 it is set to other values.
> Finally, the routine returns as if it copied 12 (=ENOMEM) bytes less than
> it actually did.
> 
Is there any reason copied shouldn't get set to 0 just prior to entering
the while loop?

> Amnon.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
