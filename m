Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVCBNd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVCBNd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 08:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVCBNd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 08:33:57 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:27143 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262290AbVCBNd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 08:33:56 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Justin Schoeman <justin@expertron.co.za>, linux-kernel@vger.kernel.org
Subject: Re: Tracing memory leaks (slabs) in 2.6.9+ kernels?
References: <4225768B.3010005@expertron.co.za>
	<20050302012444.4ed05c23.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 02 Mar 2005 22:32:44 +0900
In-Reply-To: <20050302012444.4ed05c23.akpm@osdl.org> (Andrew Morton's
 message of "Wed, 2 Mar 2005 01:24:44 -0800")
Message-ID: <87ekeyb2bn.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> +		slab_bufctl(slabp)[objnr] = (unsigned long)caller;

Umm... this patch looks strange..

slab_bufctl() returns "kmem_bufctl_t *", but kmem_bufctl_t is
"unsigned short".

I guess that this debug patch was broken by something else...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
