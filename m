Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264778AbTIJJIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264780AbTIJJIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:08:53 -0400
Received: from waste.org ([209.173.204.2]:31170 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264778AbTIJJIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:08:51 -0400
Date: Wed, 10 Sep 2003 04:08:46 -0500
From: Matt Mackall <mpm@selenic.com>
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rjwalsh@durables.org
Subject: Re: [PATCH 1/3] netpoll api
Message-ID: <20030910090846.GI4489@waste.org>
References: <20030910074030.GC4489@waste.org> <20030910004907.67b90bd1.akpm@osdl.org> <20030910081845.GF4489@waste.org> <20030910083935.GG1532@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910083935.GG1532@krispykreme>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 06:39:35PM +1000, Anton Blanchard wrote:
>  
> > Hmmm, linux/irq.h seemed pretty generic. Maybe those other, silly
> > arches can mend their ways?
> 
> linux/irq.h:
> 
> /*
>  * Please do not include this file in generic code.  There is currently
>  * no requirement for any architecture to implement anything held
>  * within this file.
>  *
>  * Thanks. --rmk
>  */
> 
> Generic? Nice try :)

But, uh, all my comments show up in a Greek font. Or something..

(the real problem is that I jumped straight to the structure in LXR)
 
> > Ok, looks like m68k, s390, and sparcx are the only ones not using
> > irq_desc, and only s390 seems to be far from the irq_desc model. Or I
> > could be quite mistaken.
> 
> irq_desc will probably die in 2.7, replaced with some helper macros. Its
> not a neat fit for many arches (ppc64 included).

Well I'll come up with something for x86 tomorrow and when helper
macros materialize, I'll use them.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
