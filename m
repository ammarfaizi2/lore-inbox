Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVCBJSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVCBJSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 04:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVCBJSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 04:18:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:32178 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262236AbVCBJSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 04:18:22 -0500
Date: Wed, 2 Mar 2005 01:14:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [2.6.11-rc5-mm1 patch] reiser4 Kconfig help cleanup
Message-Id: <20050302011448.37f1e951.akpm@osdl.org>
In-Reply-To: <yq0is4afml7.fsf@jaguar.mkp.net>
References: <20050301012741.1d791cd2.akpm@osdl.org>
	<20050301234324.GJ4845@stusta.de>
	<yq0is4afml7.fsf@jaguar.mkp.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@wildopensource.com> wrote:
>
> >>>>> "Adrian" == Adrian Bunk <bunk@stusta.de> writes:
> 
> Adrian> The current reiser4 help texts have two disadvantages: 1. they
> Adrian> are more marketing speech than technical speech with some
> Adrian> debatable statements 2. they are too long
> 
> Excellent patch, that help description has been totally inappropriate
> since it was first introduced. I'm sure it will do fine on namesys'
> website, but not in the kernel.
> 
> Adrian> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Signed-off-by: Jes Sorensen <jes@wildopensource.com>
> 
> Speaking of inappropriate components in reiser4:
> 
> [jes@tomahawk linux-2.6.11-rc5-mm1]$ grep PG_arch fs/reiser4/*.c
> fs/reiser4/page_cache.c:               page_flag_name(page, PG_arch_1),
> fs/reiser4/txnmgr.c:                    assert("vs-1448", test_and_clear_bit(PG_arch_1, &node->pg->flags));
> fs/reiser4/txnmgr.c:            ON_DEBUG(set_bit(PG_arch_1, &(copy->pg)->flags));
> 
> Someone was obviously smoking something illegal, what part of 'arch'
> did she/he not understand? I assume we can request this is fixed by
> the patch owner asap.
> 

Could the reiserfs team please comment?

If it's just debug then probably it would be better to add a new flag.

If these pages are never mmapped then it'll just happen to work, I guess. 
But a filesystem really shouldn't be dinking with PG_arch_1.

