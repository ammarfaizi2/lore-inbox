Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290746AbSBGRxg>; Thu, 7 Feb 2002 12:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290747AbSBGRx0>; Thu, 7 Feb 2002 12:53:26 -0500
Received: from dsl-213-023-038-235.arcor-ip.net ([213.23.38.235]:2192 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290746AbSBGRxI>;
	Thu, 7 Feb 2002 12:53:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: The IBM order relaxation patch
Date: Thu, 7 Feb 2002 18:57:44 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <OFDEA688CD.7104528D-ONC1256B59.00522C09@de.ibm.com>
In-Reply-To: <OFDEA688CD.7104528D-ONC1256B59.00522C09@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Ysnp-00014r-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 7, 2002 04:05 pm, Ulrich Weigand wrote:
> Rik van Riel wrote:
> 
> >On Thu, 7 Feb 2002, Daniel Phillips wrote:
> >
> >> Yes, that's one of leading reasons for wanting rmap.  (Number one and
> >> two reasons are: allow forcible unmapping of multiply referenced pages
> >> for swapout; get more reliable hardware ref bit readings.)
> >
> >It's still on my TODO list.  Patches are very much welcome
> >though ;)
> 
> On s390 we have per physical page hardware referenced / changed bits.
> In the rmap framework, it should also be possible to make more efficient
> use of these ...

I'm an rmap fan, but this feature in fact negates one of the advantages of
rmap since since virtual scanning doesn't needs to propagate the page ref
bit into the physical page.  However, it still has to unmap pages, which
is the biggest disconnect with virtual scanning.

As Rik said, it would make rmap run a little faster, but some organization
is needed to make the ref bit propagation per-arch.

-- 
Daniel
