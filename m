Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVHUI0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVHUI0u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 04:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVHUI0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 04:26:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29139 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750711AbVHUI0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 04:26:48 -0400
Date: Sun, 21 Aug 2005 01:25:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Houston <jim.houston@ccur.com>
Cc: luben_tuikov@adaptec.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, davej@redhat.com, jgarzik@pobox.com
Subject: Re: [PATCH 2.6.12.5 1/2] lib: allow idr to be used in irq context
Message-Id: <20050821012506.5b106dab.akpm@osdl.org>
In-Reply-To: <1124294489.2802.107.camel@new.localdomain>
References: <430262C5.20503@adaptec.com>
	<1124294489.2802.107.camel@new.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston <jim.houston@ccur.com> wrote:
>
> On Tue, 2005-08-16 at 18:03, Luben Tuikov wrote:
> 
> > If idr_get_new() or idr_remove() is used in IRQ context,
> > then we may get a lockup when idr_pre_get was called
> > in process context and an IRQ interrupted while it held
> > the idp lock.
> 
> Hi Everyone,
> 
> Luben's changes make sense please merge them.
> 

Well yes, the change makes sense if there's actually a caller which needs it.

If there is such a caller then Luben should identify it, please.
