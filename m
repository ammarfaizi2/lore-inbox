Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129823AbQKBNyM>; Thu, 2 Nov 2000 08:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131605AbQKBNyC>; Thu, 2 Nov 2000 08:54:02 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:15348 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129823AbQKBNxp>; Thu, 2 Nov 2000 08:53:45 -0500
Date: Thu, 2 Nov 2000 11:49:01 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Anthony Towns <aj@azure.humbug.org.au>
cc: "'Pasi Kärkkäinen'" <pk@edu.joroinen.fi>,
        "Forever shall I be." <zinx@microsoftisevil.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 3-order allocation failed
In-Reply-To: <20001102082043.C22439@azure.humbug.org.au>
Message-ID: <Pine.LNX.4.21.0011021148330.15168-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Anthony Towns wrote:
> On Wed, Nov 01, 2000 at 01:42:17PM -0800, Dunlap, Randy wrote:
> > > Is this bug in the usb-driver (usb-uhci), in the camera's driver
> > > (cpia_usb) or in the v4l?
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > Could there be a memory leak as well?  But I expect that
> > it's simply that memory is just fragmented so that enough
> > contiguous pages aren't available, like Rik said.
> 
> There is a memory leak, the memory kmalloc'ed in cpia_usb_open
> for sbuf[*].data is never kfree'd

This way you'll be running out of order-2 free memory
segments /very/ quickly ... ;)

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
