Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311242AbSCSNyV>; Tue, 19 Mar 2002 08:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311241AbSCSNyL>; Tue, 19 Mar 2002 08:54:11 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:43257 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S311240AbSCSNx5>; Tue, 19 Mar 2002 08:53:57 -0500
Date: Tue, 19 Mar 2002 21:53:35 +0800 (MYT)
From: David Woodhouse <dwmw2@infradead.org>
X-X-Sender: dwmw2@lapdancer.baythorne.internal
To: David Woodhouse <dwmw2@redhat.com>
cc: Paul Mackerras <paulus@samba.org>, "J.A. Magallon" <jamagallon@able.es>,
        <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zlib double-free bug 
In-Reply-To: <Pine.LNX.4.44.0203191044150.26226-100000@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0203192141290.6019-100000@lapdancer.baythorne.internal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, David Woodhouse wrote:

> For the record - it's not worth bothering with fs/jffs2/zlib.c; if they 
> can corrupt your file system on the medium, why bother with cracking zlib? 
> :)

To preempt anyone else objecting to this...

I mean, given that we have a CRC on jffs2 nodes anyway, so the chances of
any accidentally corrupted input actually being fed to the decompressor
are virtually zero, it's not worth patching the 2.4.19 zlib when I want to
put the shared zlib into 2.4.20 anyway.

I'm not going to object to anyone else doing so, but I can't be bothered
to do it myself, as it would have virtually zero benefit and would mean
I'd have to update the shared-zlib patches for 2.4.

Infinitely more people (i.e. at least one) have been bitten by the fact
that you can't build both ppp_deflate and jffs2 into a 2.4 kernel.

-- 
dwmw2

