Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275447AbRJAThw>; Mon, 1 Oct 2001 15:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275434AbRJAThm>; Mon, 1 Oct 2001 15:37:42 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20496 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275421AbRJAThh>; Mon, 1 Oct 2001 15:37:37 -0400
Subject: Re: VM: 2.4.10 vs. 2.4.10-ac2 and qsort()
To: riel@conectiva.com.br (Rik van Riel)
Date: Mon, 1 Oct 2001 20:42:27 +0100 (BST)
Cc: lenstra@tiscalinet.it (Lorenzo Allegrucci), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.33L.0110011604310.4835-100000@imladris.rielhome.conectiva> from "Rik van Riel" at Oct 01, 2001 04:23:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15o8xP-0002H3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sure either, since qsort doesn't really have much
> locality of reference but just walks all over the place.

qsort can be made to perform reasonably well providing you try to cache
colour the objects you sort and try to use prefetches a bit. 

> I wonder how eg. merge sort would perform ...
 
Generally better but thats seperate to the VM issues.

> One thing which could make 2.4.10 faster for this single case
> is the fact that it doesn't keep any page aging info, so IO
> clustering won't be confused by the process accessing its
> pages ;)

I don't think that is too unusual a case. If the smarter vm is making poorer
I/O clustering decisions it wants investigating
