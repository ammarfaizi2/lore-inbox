Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130163AbRAERqu>; Fri, 5 Jan 2001 12:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131633AbRAERqa>; Fri, 5 Jan 2001 12:46:30 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:48134 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129857AbRAERq2>; Fri, 5 Jan 2001 12:46:28 -0500
Date: Fri, 5 Jan 2001 13:54:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: MM/VM todo list
In-Reply-To: <Pine.LNX.4.21.0101051505430.1295-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101051344270.2745-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Jan 2001, Rik van Riel wrote:

> Hi,
> 
> here is a TODO list for the memory management area of the
> Linux kernel, with both trivial things that could be done
> for later 2.4 releases and more complex things that really
> have to be 2.5 things.
> 
> Most of these can be found on http://linux24.sourceforge.net/ too
> 
> Trivial stuff:
> * VM: better IO clustering for swap (and filesystem) IO
>   * Marcelo's swapin/out clustering code
    * Swap space preallocation at try_to_swap_out()

>   * ->writepage() IO clustering support

Hum, IMO this should be in the "2.5" list because 

1) It involves changes to the PageDirty scheme if we want to support write
clustering for normal writes, and not only shared writable mappings like
we do now. (basically this changes are in Chris Mason's patch)

2) It involves changes to the filesystem code if we want to support
generic write clustering for fs's which use block_write_full_page.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
