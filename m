Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291806AbSBHVGO>; Fri, 8 Feb 2002 16:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291812AbSBHVGF>; Fri, 8 Feb 2002 16:06:05 -0500
Received: from mail305.mail.bellsouth.net ([205.152.58.165]:49181 "EHLO
	imf05bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S291806AbSBHVGA>; Fri, 8 Feb 2002 16:06:00 -0500
Subject: Re: Problem with rmap-12c
From: Louis Garcia <louisg00@bellsouth.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0202072006010.17850-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0202072006010.17850-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 (1.0.2-1) 
Date: 08 Feb 2002 16:06:13 -0500
Message-Id: <1013202380.1153.7.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I've tried rmap-12d and the swaping is better but still worse then
12a. One thing I should say is I'm also using Andrews low latency patch.

Is you want vm stats let me know.

--Louis


On Thu, 2002-02-07 at 17:12, Rik van Riel wrote:
> On 7 Feb 2002, Louis Garcia wrote:
> 
> > I tried rmap-12c and had lots of swap usage. I when back to 12a and
> > everything calmed down. Is their a known problem with 12c?
> 
> Nope, but the RSS limit enforcing stuff is a possible
> suspect.
> 
> It turns out I used a "struct pte_t" in over_rss_limit(),
> which turned into a compiler warning, for which I didn't
> spot the cause ;)
> 
> A fix for the bug was sent by Roger Larsson, who spotted
> the fact that "pte_t" already has a "struct" inside it.
> 
> Maybe page aging isn't working in rmap-12c because of this
> stupid mistake ... but it's a long shot.  Maybe I should
> release rmap 12d tonight ? ;)
> 
> regards,
> 
> Rik
> -- 
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 


