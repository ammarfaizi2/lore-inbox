Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317391AbSGTOOb>; Sat, 20 Jul 2002 10:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317401AbSGTOOb>; Sat, 20 Jul 2002 10:14:31 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:11141 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S317391AbSGTOO2>; Sat, 20 Jul 2002 10:14:28 -0400
Date: Sat, 20 Jul 2002 07:15:08 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: [PATCH 6/6] Updated VM statistics patch
In-Reply-To: <Pine.LNX.4.44L.0207201006100.12241-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0207200645360.6298-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 20 Jul 2002, Rik van Riel wrote:

> Except for the fact that you'll count every new page allocation
> as an activation, which isn't quite the intended behaviour ;)

*thwaps forehead*   Ohhh, quite right.  Darn.  :) 

Hmmm.  Does it sound acceptable to still increment pgdeactivate in
mm_inline.h, and explicitly put hooks for pgactivate in the select places
where pages really _are_ being 'reactivated'?  That sounds fairly sensible
to me -- unless you want to differentiate between pages that leave the
active list via drop_behind() versus deactivate_page_nolock().

Many thanks,
-Craig

