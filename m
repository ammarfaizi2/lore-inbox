Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291151AbSBGPDR>; Thu, 7 Feb 2002 10:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291152AbSBGPDH>; Thu, 7 Feb 2002 10:03:07 -0500
Received: from dsl-213-023-038-235.arcor-ip.net ([213.23.38.235]:64395 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291151AbSBGPDC>;
	Thu, 7 Feb 2002 10:03:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: The IBM order relaxation patch
Date: Thu, 7 Feb 2002 16:07:39 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, <zaitcev@redhat.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0202071254430.17850-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0202071254430.17850-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Yq9D-0000bD-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 7, 2002 03:55 pm, Rik van Riel wrote:
> On Thu, 7 Feb 2002, Daniel Phillips wrote:
> 
> > > This looks hard to fix with the current mm layer.  Maybe Rik's
> > > rmap method could help here, because with reverse mappings we
> > > can at least try to free adjacent areas (because we then at least
> > > *know* who's using the pages).
> >
> > Yes, that's one of leading reasons for wanting rmap.  (Number one and
> > two reasons are: allow forcible unmapping of multiply referenced pages
> > for swapout; get more reliable hardware ref bit readings.)
> 
> It's still on my TODO list.  Patches are very much welcome
> though ;)

I'd rather see rmap go in in its simplest possible form, outperforming the
current virtual scanning method on basic page replacement performance, rather 
that using the other things we know rmap can do as the argument for inclusion.
It's for this reason that I'm concentrating on the fork speedup.

-- 
Daniel
