Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293484AbSBZCSd>; Mon, 25 Feb 2002 21:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293485AbSBZCSX>; Mon, 25 Feb 2002 21:18:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24846 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293484AbSBZCSO>;
	Mon, 25 Feb 2002 21:18:14 -0500
Message-ID: <3C7AF011.8B6ECCF0@zip.com.au>
Date: Mon, 25 Feb 2002 18:16:49 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "Marcelo W. Tosatti" <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct page shrinkage
In-Reply-To: <Pine.LNX.4.33L.0202252245460.7820-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> +               clear_bit(PG_locked, &p->flags);

Please don't do this.  Please use the macros.  If they're not
there, please create them.

Bypassing the abstractions in this manner confounds people
who are implementing global locked-page accounting.

In fact, I think I'll go rename all the page flags...

-
