Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271520AbRHPI0Y>; Thu, 16 Aug 2001 04:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271522AbRHPI0O>; Thu, 16 Aug 2001 04:26:14 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:24595 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271520AbRHPI0J>; Thu, 16 Aug 2001 04:26:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: David Ford <david@erisksecurity.com>, linux-kernel@vger.kernel.org
Subject: Re: VM and N-order allocation failed.
Date: Thu, 16 Aug 2001 10:32:41 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <3B7AE7D2.3070900@erisksecurity.com>
In-Reply-To: <3B7AE7D2.3070900@erisksecurity.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010816082620Z16213-1231+1148@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 15, 2001 11:21 pm, David Ford wrote:
> I've a friend who has a small box doing routing/firewalling/nat for a 
> /27 and the bandwidth is pretty tiny.  The machine has 32megs of ram and 
> 100 in swap.
> 
> It dies anywhere from an hour after reboot to 12 hours later, on console 
> are messages like so "__alloc_pages: 0-order allocation failed." and 
> "ip_conntrack: table full, dropping packet."
> 
> His prior kernel was 2.4.7, nothing special, he's using 3com 
> 3cSOHO100-TX and Cpq Neteligent 10/100.  I just upped him to 2.4.8 as a 
> starter and we'll see how it's going.  I don't have direct access to the 
> box so I can't give complete information.
> 
> Comments and suggestions welcomed,

We should add the GFP_* allocation flags to that allocation failed
message so we know whether it's atomic, noio, nofs, highmem or what.

Please define 'it dies' a little more precisely - oops, deadlock,
livelock, app terminated or what.  Then please supply the /proc/meminfo
if possible or shift-ScrLk dump to console (roughly the same thing).

He needs to upgrade 2.4.9-preX because that is where the VM work is
being done.  Finally, it would be worth merging this thread with the
following thread on linux-mm:

  0-order allocation problem

--
Daniel
