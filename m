Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130670AbRAERPJ>; Fri, 5 Jan 2001 12:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRAERPD>; Fri, 5 Jan 2001 12:15:03 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:41725 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131384AbRAEROq>; Fri, 5 Jan 2001 12:14:46 -0500
Date: Fri, 5 Jan 2001 15:14:08 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org
Subject: MM/VM todo list
Message-ID: <Pine.LNX.4.21.0101051505430.1295-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is a TODO list for the memory management area of the
Linux kernel, with both trivial things that could be done
for later 2.4 releases and more complex things that really
have to be 2.5 things.

Most of these can be found on http://linux24.sourceforge.net/ too

Trivial stuff:
* VM: better IO clustering for swap (and filesystem) IO
  * Marcelo's swapin/out clustering code
  * ->writepage() IO clustering support
  * page_launder()/->writepage() working together in avoiding
    low-yield (small cluster) IO at first, ...
* VM: include Ben LaHaise's code, which moves readahead to the
  VMA level, this way we can do streaming swap IO, complete with
  drop_behind()
* VM: enforce RSS ulimit


Probably 2.5 era:
* VM: physical->virtual reverse mapping, so we can do much
  better page aging with less CPU usage spikes 
* VM: move all the global VM variables, lists, etc. into the
  pgdat struct for better NUMA scalability
* VM: per-node kswapd for NUMA
* VM: thrashing control, maybe process suspension with some
  forced swapping ?             (trivial only in theory)
* VM: experiment with different active lists / aging pages
  of different ages at different rates + other page replacement
  improvements
* VM: Quality of Service / fairness / ... improvements


Additions to this list are always welcome, I'll put it online
on the Linux-MM pages (http://www.linux.eu.org/Linux-MM/) soon.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
