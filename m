Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130452AbRCIIjg>; Fri, 9 Mar 2001 03:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130453AbRCIIj1>; Fri, 9 Mar 2001 03:39:27 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:2053 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S130452AbRCIIjI>; Fri, 9 Mar 2001 03:39:08 -0500
Message-ID: <3AA89624.46DBADD7@idb.hist.no>
Date: Fri, 09 Mar 2001 09:36:52 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Manoj Sontakke <manojs@sasken.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: quicksort for linked list
In-Reply-To: <3AA88891.294C17A0@sasken.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manoj Sontakke wrote:
> 
> Hi
>         Sorry, these questions do not belog here but i could not find any
> better place.
> 
> 1. Is quicksort on doubly linked list is implemented anywhere? I need it
> for sk_buff queues.

I cannot see how the quicksort algorithm could work on a doubly
linked list, as it relies on being able to look
up elements directly as in an array.

You can probably find algorithms for sorting a linked list, but
it won't be quicksort.

You can however quicksort the list _if_ you have room enough for an
additional data structure:

1. find out how many elements there are.  (Count them if necessary)
2. Allocate a pointer array of this size.
3. fill the pointer array with pointers to list members.
4. quicksort the pointer array
5. Traverse the pointer array and set the links for each
   list member to point to next/previous element pointed
   to by the array.  Now you have a sorted linked list!

Steps 1,2,3 & 5 are all O(n), better than the O(nlgn) for
quicksort.  


Helge Hafting
