Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130915AbQKQTnk>; Fri, 17 Nov 2000 14:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131007AbQKQTnb>; Fri, 17 Nov 2000 14:43:31 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:6133 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130915AbQKQTnZ>; Fri, 17 Nov 2000 14:43:25 -0500
Date: Fri, 17 Nov 2000 17:12:07 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: schwidefsky@de.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
        mingo@chiara.elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Memory management bug
In-Reply-To: <20001117164422.B27098@athlon.random>
Message-ID: <Pine.LNX.4.21.0011171706250.371-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Andrea Arcangeli wrote:

> Actually memory balancing in 2.4.x doesn't get any information,
> not even the information about which _classzone_ where to free
> the memory (NOTE: both 2.2.x and 2.0.x _always_ got the
> classzone where to free memory at least). This classzone missing
> information causes resources wastage indeed and I just fixed it
> several times, BTW.

Interesting, I can't remember you sending me any
patches...

Also, the 2.4 VM (unlike the other VMs) doesn't actually
FREE memory wrongly (with the exception of buffer cache
pages from page_launder()) but just moves it to the
inactive_clean list, from where it will be re-used by one
of those 99% user level allocations that happen on a typical
Linux system.

But, as I said in Ottawa, I wouldn't mind any classzone
stuff in the new VM, as long as it won't complicate the
integration of _other_ memory organisations (like NUMA).

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
