Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268669AbUHYU1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268669AbUHYU1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268596AbUHYUZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:25:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4318 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268601AbUHYUWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:22:50 -0400
Date: Wed, 25 Aug 2004 16:22:32 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Con Kolivas <kernel@kolivas.org>
cc: ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-ck4
In-Reply-To: <412880BF.6050503@kolivas.org>
Message-ID: <Pine.LNX.4.44.0408251621160.5145-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004, Con Kolivas wrote:

> Added since 2.6.8.1-ck3:
> +mapped_watermark.diff

Sounds like a bad idea for file servers ;)

Wouldn't it be better to lazily move these cached pages to
a "cached" list like the BSDs have, and reclaim it immediately
when the memory is needed for something else ?

It should be easy enough to keep the cached data around and
still have the cache pages easily reclaimable.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

