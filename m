Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262616AbREZIKf>; Sat, 26 May 2001 04:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262617AbREZIKZ>; Sat, 26 May 2001 04:10:25 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:23565 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262616AbREZIKR>; Sat, 26 May 2001 04:10:17 -0400
Date: Sat, 26 May 2001 01:10:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0105260129390.30264-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0105260101370.1901-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 May 2001, Rik van Riel wrote:
> 
> This is exactly what gets fixed in the patch I sent you.

This is not AT ALL what your patch does. 99% of your patch does other
things, including playing games with the "balance dirty" threshold etc. In
ways that make it look very much like the standard dbench kind of load
cannot use HIGHMEM for dirty buffers very effectively.

There's _one_ line of your patch special-cases GFP_BUFFER in page_alloc
and protects the reserves, but the point is that they shouldn't need
protecting: there's something else wrong that makes them be depleted in
the first place. 

Did you read my email?

		Linus


