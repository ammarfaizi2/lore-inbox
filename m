Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312442AbSDSNrr>; Fri, 19 Apr 2002 09:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312449AbSDSNrq>; Fri, 19 Apr 2002 09:47:46 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:1239 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S312442AbSDSNq4>; Fri, 19 Apr 2002 09:46:56 -0400
Date: Fri, 19 Apr 2002 14:45:22 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org,
        Leif Svalgaard <lsvalg@ibm.net.apsleyroad.org>,
        Wayne Conrad <wconrad@yagni.com>
Subject: Re: [RFC] 2.5.8 sort kernel tables
Message-ID: <20020419144521.B13926@kushida.apsleyroad.org>
In-Reply-To: <20020418135931.GU21206@holomorphy.com> <Pine.LNX.4.44.0204181507150.8537-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> Combsort is a trivial modification of bubblesort that's O(n log(n)).
> 
>  http://cs.clackamas.cc.or.us/molatore/cs260Spr01/combsort.htm

Cute.  Combsort is very closely related to Shellsort, which is tiny,
fast and old (c.1959), yet its time complexity is still not well
understood:

   http://www.cs.princeton.edu/~rs/shell/shell.c
   http://www.cs.princeton.edu/~rs/shell/

The above paper mentions a variant of Shellsort which uses a "h-bubble"
operation.  Beware!  That does probabilistic sorting, which means
"nearly always sorts, with high probability"!

I think that Combsort is equivalent to that variant of Shellsort, with
larger constant factors in its time complexity (because bubbling is
slower than insertion), and it effectively degrades to Bubblesort in the
event that the probabilistic h-bubble Shellsort fails to sort.

There are a couple of improvements to h-bubble Shellsort mentioned in
the paper which may be faster.

enjoy,
-- Jamie
