Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbQLRTk3>; Mon, 18 Dec 2000 14:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129873AbQLRTkT>; Mon, 18 Dec 2000 14:40:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14978 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129781AbQLRTkF>; Mon, 18 Dec 2000 14:40:05 -0500
Date: Mon, 18 Dec 2000 14:09:00 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: VM performance problem
In-Reply-To: <200012181844.KAA05718@pizda.ninka.net>
Message-ID: <Pine.LNX.3.95.1001218140412.5366A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000, David S. Miller wrote:

>    Date: 	Mon, 18 Dec 2000 13:54:56 -0500 (EST)
>    From: "Richard B. Johnson" <root@chaos.analogic.com>
> 
>    6/	Deallocates all the buffers by running down the linked-list.
> 
>  ...
> 
>    If the program deallocates all the buffers, as in (6) above, it will
>    take even up to 1 whole minute!! At this time, there is an enormous
>    amount of swap-file activity going on.
> 
> How exactly are these buffers allocated/deallocated?  Are you
> absolutely certain that the deallocation process does not make loads
> from or stores into the buffers as a free(3) implementation would?
> 
> That would cause the pages to be sucked back from swap space.
> 

Well I just use free(), nothing more, nothing special, just like
a typical data-base program.  Free should just set a new break
address after the reclaimed data falls below some watermarks it
has established. Both malloc() and free(), use already allocated
data-space for their work-space (last time I looked at library code).


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
