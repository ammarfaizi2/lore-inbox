Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293483AbSBZCqy>; Mon, 25 Feb 2002 21:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292690AbSBZCqo>; Mon, 25 Feb 2002 21:46:44 -0500
Received: from holomorphy.com ([216.36.33.161]:43195 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S293486AbSBZCq1>;
	Mon, 25 Feb 2002 21:46:27 -0500
Date: Mon, 25 Feb 2002 18:46:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "Marcelo W. Tosatti" <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct page shrinkage
Message-ID: <20020226024612.GO3511@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Rik van Riel <riel@conectiva.com.br>,
	"Marcelo W. Tosatti" <marcelo@conectiva.com.br>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0202252245460.7820-100000@imladris.surriel.com> <3C7AF011.8B6ECCF0@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3C7AF011.8B6ECCF0@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
>> 
>> +               clear_bit(PG_locked, &p->flags);

On Mon, Feb 25, 2002 at 06:16:49PM -0800, Andrew Morton wrote:
> Please don't do this.  Please use the macros.  If they're not
> there, please create them.
> 
> Bypassing the abstractions in this manner confounds people
> who are implementing global locked-page accounting.
> 
> In fact, I think I'll go rename all the page flags...

This is lingering context from the driver... it's ugly, I didn't
go after cleaning that up when I had to touch this function because
of the usual minimal-impact / only do one thing principle.

Perhaps others were similarly (un)motivated.


Cheers,
Bill
