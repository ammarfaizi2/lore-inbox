Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263182AbVHFNzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbVHFNzP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 09:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbVHFNzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 09:55:15 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16035
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262904AbVHFNzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 09:55:13 -0400
Date: Sat, 06 Aug 2005 06:55:20 -0700 (PDT)
Message-Id: <20050806.065520.85401639.davem@davemloft.net>
To: bboissin@gmail.com
Cc: olh@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: [PATCH] implicit declaration of function `page_cache_release'
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <40f323d00508051218c30d7af@mail.gmail.com>
References: <40f323d005080511516a81a7d6@mail.gmail.com>
	<20050805190006.GA6747@suse.de>
	<40f323d00508051218c30d7af@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benoit Boissinot <bboissin@gmail.com>
Date: Fri, 5 Aug 2005 21:18:38 +0200

> On 8/5/05, Olaf Hering <olh@suse.de> wrote:
> >  On Fri, Aug 05, Benoit Boissinot wrote:
> > 
> > Why does it need swap.h? Do the users of pgtable.h rely on swap.h?
> > 
> sparc is the only architecture to do that, it looks like it uses it
> for boot time linking (BTFIXUP_*). I don't know anything about sparc,
> so i can't fix it.
> 
> (adding sparclinux@vger.kernel.org to the cc list)

It needs to have the swp_entry_t type fully visible in pgtable.h,
we can't work around this using macros.
