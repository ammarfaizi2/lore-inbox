Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293513AbSCSCKz>; Mon, 18 Mar 2002 21:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293514AbSCSCKp>; Mon, 18 Mar 2002 21:10:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61451 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293513AbSCSCKg>; Mon, 18 Mar 2002 21:10:36 -0500
Date: Mon, 18 Mar 2002 18:08:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <Dieter.Nuetzel@hamburg.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <20020318.162031.98995076.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0203181805460.10711-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Mar 2002, David S. Miller wrote:
>    
>    Or maybe the program is just flawed, and the interesting 1/8 pattern comes 
>    from something else altogether.
> 
> I think the weird Athlon behavior has to do with the fact that
> you've made your little test program as much of a cache tester
> as a TLB tester :-)

Oh, I was assuming that malloc(BIG) would do a mmap() of MAP_ANONYMOUS, 
which should make all the pages 100% shared, and thus basically zero cache 
overhead on a physically indexed machine like an x86. 

So it was designed to reall yonly stress the TLB, not the regular caches.

Although I have to admit that I didn't actually _test_ that hypothesis.

		Linus

