Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287111AbSBIUY4>; Sat, 9 Feb 2002 15:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287439AbSBIUYr>; Sat, 9 Feb 2002 15:24:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61449 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287111AbSBIUY1>; Sat, 9 Feb 2002 15:24:27 -0500
Message-ID: <3C658566.2020603@zytor.com>
Date: Sat, 09 Feb 2002 12:24:06 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <Pine.LNX.4.33.0202091348230.1497-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> 
> Oh, but I was talking about the case of the macro being used in an "static
> inline" in a header file, and that inline is not actually _used_
> anywhere..
> 


Ah... but it was talked about in reference to a macro.

Also, since AFAIK BUG() never returns, you may want to have it end with 
for(;;); to let gcc know that any code downstream of a BUG() is dead.

	-hpa


