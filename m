Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVEKQSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVEKQSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 12:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVEKQSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 12:18:31 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:17848 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261180AbVEKQS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 12:18:28 -0400
Date: Wed, 11 May 2005 17:19:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Kirill Korotaev <dev@sw.ru>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do_swap_page() can map random data if swap read fails
In-Reply-To: <4282248F.3070206@sw.ru>
Message-ID: <Pine.LNX.4.61.0505111716390.7361@goblin.wat.veritas.com>
References: <4282248F.3070206@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 11 May 2005 16:18:25.0035 (UTC) 
    FILETIME=[0EC375B0:01C55645]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005, Kirill Korotaev wrote:

> against 2.6.12-rc4
> 
> There is a bug in do_swap_page(): when swap page happens to be unreadable,
> page filled with random data is mapped into user
> address space.
> The fix is to check for PageUptodate and send SIGBUS in case of error.
> 
> Signed-Off-By: Kirill Korotaev <dev@sw.ru>
> Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>

Ah, yes, that surprised me years ago, but I forgot all about it.

Acked-by: Hugh Dickins <hugh@veritas.com>
