Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136009AbREGFUJ>; Mon, 7 May 2001 01:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136016AbREGFT7>; Mon, 7 May 2001 01:19:59 -0400
Received: from vitelus.com ([64.81.36.147]:10513 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S136009AbREGFTr>;
	Mon, 7 May 2001 01:19:47 -0400
Date: Sun, 6 May 2001 22:19:38 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Jonathan Morton <chromi@cyberspace.org>,
        BERECZ Szabolcs <szabi@inf.elte.hu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: page_launder() bug
Message-ID: <20010506221938.A29493@vitelus.com>
In-Reply-To: <Pine.A41.4.31.0105062307290.59664-100000@pandora.inf.elte.hu> <l03130303b71b795cab9b@[192.168.239.105]> <15094.10942.592911.70443@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <15094.10942.592911.70443@pizda.ninka.net>; from davem@redhat.com on Sun, May 06, 2001 at 09:55:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 09:55:26PM -0700, David S. Miller wrote:
> 
> Jonathan Morton writes:
>  > >-			 page_count(page) == (1 + !!page->buffers));
>  > Two inversions in a row?
> It is the most straightforward way to make a '1' or '0'
> integer from the NULL state of a pointer.

page_count(page) == (1 + (page->buffers != 0));

