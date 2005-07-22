Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVGWDXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVGWDXv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 23:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVGWDXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 23:23:51 -0400
Received: from [216.208.38.107] ([216.208.38.107]:20626 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S262324AbVGWDXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 23:23:50 -0400
Subject: Re: [QN/PATCH] Why do some archs allocate stack via kmalloc,
	others via get_free_pages?
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050722.005025.26277081.davem@davemloft.net>
References: <1122005477.3033.56.camel@localhost>
	 <20050722.005025.26277081.davem@davemloft.net>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1122044224.3704.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 23 Jul 2005 00:57:04 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-07-22 at 17:50, David S. Miller wrote:
> From: Nigel Cunningham <ncunningham@cyclades.com>
> Date: Fri, 22 Jul 2005 14:11:17 +1000
> 
> > In making some modifications to Suspend, we've discovered that some
> > arches use kmalloc and others use get_free_pages to allocate the stack.
> > Is there a reason for the variation? If not, could the following patch
> > be considered for inclusion (tested on x86 only).
> 
> Some platforms really need it to be page aligned (sparc32 sun4c needs
> to virtually map the resulting pages into a specific place, for
> example).
> 
> But, for the ones that don't have this requirement, they want the
> cache coloring.

Thanks David.

Nigel

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

