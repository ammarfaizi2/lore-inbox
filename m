Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWGJKgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWGJKgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWGJKgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:36:32 -0400
Received: from mail.gmx.de ([213.165.64.21]:60854 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751252AbWGJKgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:36:31 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.18-rc1: slab BUG_ON(!PageSlab(page)) upon umount after
	failed suspend
From: Mike Galbraith <efault@gmx.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <84144f020607100333s57159d38ha1101c65e8c099b1@mail.gmail.com>
References: <6wDCq-5xj-25@gated-at.bofh.it> <6wM2X-1lt-7@gated-at.bofh.it>
	 <6wOxP-4QN-5@gated-at.bofh.it> <44B189D3.4090303@imap.cc>
	 <20060709161712.c6d2aecb.akpm@osdl.org>
	 <1152513068.7748.13.camel@Homer.TheSimpsons.net>
	 <84144f020607100142l62f02321i9802f9eed64d39f4@mail.gmail.com>
	 <1152527148.8700.8.camel@Homer.TheSimpsons.net>
	 <84144f020607100333s57159d38ha1101c65e8c099b1@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 12:42:21 +0200
Message-Id: <1152528141.9122.0.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 13:33 +0300, Pekka Enberg wrote:
> On 7/10/06, Mike Galbraith <efault@gmx.de> wrote:
> > Hm.  I've never _noticed_ gcc putting anything out there before.  This
> > is gcc version 4.1.2 20060531 (prerelease) (SUSE Linux).
> 
> [snip]
> 
> Curious... GCC cuts line and file information after ud2a. Looking at
> your stack trace, I am wondering who calls free_block() as we don't
> see cache_flusharray() in the trace. Do you have CONFIG_NUMA enabled?

Nope.


