Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284542AbRLXKGI>; Mon, 24 Dec 2001 05:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284545AbRLXKF6>; Mon, 24 Dec 2001 05:05:58 -0500
Received: from d-dialin-2782.addcom.de ([213.61.81.150]:28144 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S284542AbRLXKFq>; Mon, 24 Dec 2001 05:05:46 -0500
Date: Mon, 24 Dec 2001 01:44:17 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Andrew Morton <akpm@zip.com.au>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: How to fix false positives on references to discarded text/data?
In-Reply-To: <3C2673B3.78E21527@zip.com.au>
Message-ID: <Pine.LNX.4.33.0112240142230.1676-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, Andrew Morton wrote:

> Kai Germaschewski wrote:
> > 
> >         asm volatile(LOCK "subl $1,(%0)\n\t" \
> >                      "js 2f\n" \
> >                      "1:\n" \
> > -                    ".section .text.lock,\"ax\"\n" \
> > +                    ".subsection 1\n" \
> >                      "2:\tcall " helper "\n\t" \
> >                      "jmp 1b\n" \
> >                      ".previous" \
> 
> Don't we want `.subsection 0' here, rather than .previous?

Either should be fine.

> Apart from that, it looks like a winner.

;-)

--Kai

