Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268590AbRGYQmE>; Wed, 25 Jul 2001 12:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268591AbRGYQlz>; Wed, 25 Jul 2001 12:41:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:8462 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268590AbRGYQlk>; Wed, 25 Jul 2001 12:41:40 -0400
Date: Wed, 25 Jul 2001 13:41:43 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <0107251802300B.00907@starship>
Message-ID: <Pine.LNX.4.33L.0107251340550.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 25 Jul 2001, Daniel Phillips wrote:
> On Wednesday 25 July 2001 08:33, Marcelo Tosatti wrote:
> > Now I'm not sure why directly adding swapcache pages to the inactive
> > dirty lits with 0 zero age improves things.
>
> Because it moves the page rapidly down the inactive queue towards the
> ->writepage instead of leaving it floating around on the active ring
> waiting to be noticed.  We already know we want to evict that page,

We don't.

The page gets unmapped and added to the swap cache the first
time it wasn't referenced by the process.

This is before any page aging is done.

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

