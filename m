Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132201AbRAGWIn>; Sun, 7 Jan 2001 17:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132701AbRAGWIX>; Sun, 7 Jan 2001 17:08:23 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:42487 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132201AbRAGWIT>; Sun, 7 Jan 2001 17:08:19 -0500
Date: Sun, 7 Jan 2001 20:07:52 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: "John O'Donnell" <johnod@voicefx.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0:  __alloc_pages: 3-order allocation failed.
In-Reply-To: <3A58E69D.30005@voicefx.com>
Message-ID: <Pine.LNX.4.21.0101072006450.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, John O'Donnell wrote:

> What does this message mean in my dmesg output?
> 
> __alloc_pages: 3-order allocation failed.

It means something in the kernel is trying to allocate an
area of 8 physically contiguous pages, but that wasn't
available so the allocation failed...

This debugging check should probably be removed around
2.4.5, in the mean time it is much too useful to track
down badly behaving device drivers ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
