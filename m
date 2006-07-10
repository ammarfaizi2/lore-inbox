Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWGJLk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWGJLk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWGJLk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:40:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:47553 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932398AbWGJLk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:40:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=S9bkVrBKDYD9tEN7bhsyL8wd/kFm3WffzzA2ehinxntYNopva8xiP/KAG+848zwJqUBlTvTuGJ62YFwKN7WGNaeOzIVbJCpwQNOgdJTphOGSS/9ZJDTDvi+iwbDqXYHr1bwOYtkgqFzDkw6FEPjZ2njKRv0HAGVI9Q/EdHMwMlE=
Message-ID: <84144f020607100440m2522fccie2b009a6a19fb630@mail.gmail.com>
Date: Mon, 10 Jul 2006 14:40:26 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Mike Galbraith" <efault@gmx.de>
Subject: Re: 2.6.18-rc1: slab BUG_ON(!PageSlab(page)) upon umount after failed suspend
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1152528686.9122.5.camel@Homer.TheSimpsons.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6wDCq-5xj-25@gated-at.bofh.it> <6wM2X-1lt-7@gated-at.bofh.it>
	 <6wOxP-4QN-5@gated-at.bofh.it> <44B189D3.4090303@imap.cc>
	 <20060709161712.c6d2aecb.akpm@osdl.org>
	 <1152513068.7748.13.camel@Homer.TheSimpsons.net>
	 <84144f020607100142l62f02321i9802f9eed64d39f4@mail.gmail.com>
	 <1152527148.8700.8.camel@Homer.TheSimpsons.net>
	 <84144f020607100333s57159d38ha1101c65e8c099b1@mail.gmail.com>
	 <1152528686.9122.5.camel@Homer.TheSimpsons.net>
X-Google-Sender-Auth: bfcb6b2af811cc49
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 13:33 +0300, Pekka Enberg wrote:
> > Curious... GCC cuts line and file information after ud2a. Looking at
> > your stack trace, I am wondering who calls free_block() as we don't
> > see cache_flusharray() in the trace. Do you have CONFIG_NUMA enabled?

On 7/10/06, Mike Galbraith <efault@gmx.de> wrote:
> It got inlined.

Right. Can't spot anything obviously wrong with the code. Try
CONFIG_DEBUG_SLAB if you can reproduce it.

                              Pekka
