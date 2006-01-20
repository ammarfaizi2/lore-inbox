Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWATLks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWATLks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWATLks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:40:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750757AbWATLks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:40:48 -0500
Date: Fri, 20 Jan 2006 03:40:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm2
Message-Id: <20060120034027.665eb101.akpm@osdl.org>
In-Reply-To: <84144f020601200333y2d2c994av96d855e300411006@mail.gmail.com>
References: <20060120031555.7b6d65b7.akpm@osdl.org>
	<84144f020601200333y2d2c994av96d855e300411006@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> Hi Andrew,
> 
> On 1/20/06, Andrew Morton <akpm@osdl.org> wrote:
> +produce-useful-info-for-kzalloc-with-debug_slab.patch
> >
> >  Make kzalloc() play properly with slab debugging
> 
> Hmm. This still leaves kstrdup() broken which is why I would prefer
> the following patch to be applied:

kstrdup() doesn't get used much.

> http://marc.theaimsgroup.com/?l=linux-kernel&m=113767657400334&w=2

That adds more complexity, IMO.  A bit ifdeffy too.  __do_kmalloc() should
be __always_inline, methinks?
