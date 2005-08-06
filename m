Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVHFPBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVHFPBL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 11:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVHFPBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 11:01:11 -0400
Received: from mx1.suse.de ([195.135.220.2]:5060 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262393AbVHFPBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 11:01:09 -0400
Date: Sat, 6 Aug 2005 17:01:03 +0200
From: Olaf Hering <olh@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: bboissin@gmail.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: [PATCH] implicit declaration of function `page_cache_release'
Message-ID: <20050806150103.GA21821@suse.de>
References: <40f323d005080511516a81a7d6@mail.gmail.com> <20050805190006.GA6747@suse.de> <40f323d00508051218c30d7af@mail.gmail.com> <20050806.065520.85401639.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050806.065520.85401639.davem@davemloft.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Aug 06, David S. Miller wrote:

> From: Benoit Boissinot <bboissin@gmail.com>
> Date: Fri, 5 Aug 2005 21:18:38 +0200
> 
> > On 8/5/05, Olaf Hering <olh@suse.de> wrote:
> > >  On Fri, Aug 05, Benoit Boissinot wrote:
> > > 
> > > Why does it need swap.h? Do the users of pgtable.h rely on swap.h?
> > > 
> > sparc is the only architecture to do that, it looks like it uses it
> > for boot time linking (BTFIXUP_*). I don't know anything about sparc,
> > so i can't fix it.
> > 
> > (adding sparclinux@vger.kernel.org to the cc list)
> 
> It needs to have the swp_entry_t type fully visible in pgtable.h,
> we can't work around this using macros.

So the patch should be reverted? Its only for CONFIG_SWAP=n, rather
unusual for KDE/GNOME tainted workstations...
