Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKPWBS>; Thu, 16 Nov 2000 17:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129222AbQKPWBI>; Thu, 16 Nov 2000 17:01:08 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:17147 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129183AbQKPWBA>; Thu, 16 Nov 2000 17:01:00 -0500
Date: Thu, 16 Nov 2000 19:30:46 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Christoph Rohland <cr@sap.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: shm swapping in 2.4 again
In-Reply-To: <m3snord2p7.fsf@linux.local>
Message-ID: <Pine.LNX.4.21.0011161929080.13085-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Nov 2000, Christoph Rohland wrote:

> Oh, I missed one point: we need to handle the swapout of
> nonattached pages: in shm you can detach the last user and the
> segment with content is still around. So we have to scan the shm
> objects themselves also. Should We could do this in the same
> loop as we scan the mm's?

Sounds like a good idea. If we scan the nonattached segments
just as agressively as we scan the mm's, things should be
balanced just fine.

> Also we have to make sure to derefence the swap entry if the
> last reference is in the shm segmant table .

Why is this?

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
