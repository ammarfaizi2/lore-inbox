Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261251AbRENN7f>; Mon, 14 May 2001 09:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbRENN7Z>; Mon, 14 May 2001 09:59:25 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:36366 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261251AbRENN7K>; Mon, 14 May 2001 09:59:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] filemap.c fixes
Date: Mon, 14 May 2001 15:54:43 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105140057180.4671-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.21.0105140057180.4671-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Message-Id: <01051415544304.02742@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 May 2001 06:00, Rik van Riel wrote:

> +	if (!PageActive(page))
> +		activate_page(page);
> +	else
> +		SetPageReferenced(page);
> +

How about:

> +	if (PageActive(page))
> +		SetPageReferenced(page);
> +	else
> +		activate_page(page);

--
Daniel

