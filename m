Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVCBOcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVCBOcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVCBOcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:32:21 -0500
Received: from [213.85.13.118] ([213.85.13.118]:57217 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S262312AbVCBO3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:29:15 -0500
To: linux-kernel@vger.kernel.org
Cc: bunk@stusta.de, Andrew Morton <akpm@osdl.org>, reiserfs-dev@namesys.com
Subject: Re: [2.6.11-rc5-mm1 patch] reiser4 Kconfig help cleanup
References: <20050301012741.1d791cd2.akpm@osdl.org>
	<20050301234324.GJ4845@stusta.de> <yq0is4afml7.fsf@jaguar.mkp.net>
	<20050302011448.37f1e951.akpm@osdl.org>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Wed, 02 Mar 2005 17:29:08 +0300
In-Reply-To: <20050302011448.37f1e951.akpm@osdl.org> (Andrew Morton's
 message of "Wed, 2 Mar 2005 01:14:48 -0800")
Message-ID: <m1vf8aktor.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Jes Sorensen <jes@wildopensource.com> wrote:
>>

[...]

>> 
>> [jes@tomahawk linux-2.6.11-rc5-mm1]$ grep PG_arch fs/reiser4/*.c
>> fs/reiser4/page_cache.c:               page_flag_name(page, PG_arch_1),
>> fs/reiser4/txnmgr.c:                    assert("vs-1448", test_and_clear_bit(PG_arch_1, &node->pg->flags));
>> fs/reiser4/txnmgr.c:            ON_DEBUG(set_bit(PG_arch_1, &(copy->pg)->flags));
>> 
>> Someone was obviously smoking something illegal, what part of 'arch'
>> did she/he not understand? I assume we can request this is fixed by
>> the patch owner asap.
>> 
>
> Could the reiserfs team please comment?
>
> If it's just debug then probably it would be better to add a new flag.
>

Yes, this is debugging. I believe it can be removed now.

> If these pages are never mmapped then it'll just happen to work, I guess. 
> But a filesystem really shouldn't be dinking with PG_arch_1.

Nikita.
