Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270660AbRHJWBZ>; Fri, 10 Aug 2001 18:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270661AbRHJWBQ>; Fri, 10 Aug 2001 18:01:16 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:14348 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270659AbRHJWBA>; Fri, 10 Aug 2001 18:01:00 -0400
Message-ID: <3B745990.7040808@zytor.com>
Date: Fri, 10 Aug 2001 15:00:48 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: /proc/<n>/maps getting _VERY_ long
In-Reply-To: <Pine.LNX.4.33.0108101445350.7596-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> These days, the vma's just have too much information, and the
> page tables
> can't be counted on to have enough bits.
> 

Note that it isn't very hard to deal with *that* problem, *if you want 
to*... you just need to maintain a shadow data structure in the same 
format as the page tables and stuff your software bits in there.

Whether or not that is a good idea is another issue entirely, however, 
on some level it would make sense to separate protection from all the 
other VM things...

	-hpa

