Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263156AbVF3Vlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbVF3Vlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 17:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbVF3VlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 17:41:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18066 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S263034AbVF3Vip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 17:38:45 -0400
Date: Thu, 30 Jun 2005 13:50:53 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Olivier Croquette <ocroquette@free.fr>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: setitimer expire too early (Kernel 2.4)
Message-ID: <20050630165053.GA8220@logos.cnet>
References: <42C444AA.2070508@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C444AA.2070508@free.fr>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 09:14:50PM +0200, Olivier Croquette wrote:
> 
> I am refering to this bug:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=4569
> 
> A thread led to a patch from Paulo:
> 
> http://kerneltrap.org/mailarchive/1/message/59454/flat
> 
> This patch has been included in the kernel 2.6.12.
> 
> 1. How can I easily check if the patch is planned for include in the 2.4?
> 
> 2. I downloaded the full 2.4.31 source code. The patch appears not to be 
> included. Where/Who should I signal that?

And what about the side effects:
This however will produce pathological cases, like having a idle system
being requested 1 ms timeouts will give systematically 2 ms timeouts,
whereas currently it simply gives a few usecs less than 1 ms. 

Linus, Andrew, do you consider this critical enough to be merged to 
the v2.4 tree?
