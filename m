Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132922AbREJTxA>; Thu, 10 May 2001 15:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135699AbREJTwu>; Thu, 10 May 2001 15:52:50 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:7553 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132922AbREJTwj>; Thu, 10 May 2001 15:52:39 -0400
Date: Thu, 10 May 2001 20:52:04 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Mark Hemment <markhe@veritas.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] allocation looping + kswapd CPU cycles
Message-ID: <20010510205204.O16590@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0105100935040.31900-100000@alloc> <Pine.LNX.4.21.0105101341130.19732-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105101341130.19732-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, May 10, 2001 at 01:43:46PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 10, 2001 at 01:43:46PM -0300, Marcelo Tosatti wrote:

> No. __GFP_FAIL can to try to reclaim pages from inactive clean.
> 
> We just want to avoid __GFP_FAIL allocations from going to
> try_to_free_pages().

Why?  __GFP_FAIL is only useful as an indication that the caller has
some magic mechanism for coping with failure.  There's no other
information passed, so a brief call to try_to_free_pages is quite
appropriate.

--Stephen
