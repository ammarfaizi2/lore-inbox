Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261864AbREZW7G>; Sat, 26 May 2001 18:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261843AbREZW66>; Sat, 26 May 2001 18:58:58 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262558AbREZW6t>;
	Sat, 26 May 2001 18:58:49 -0400
Date: Sat, 26 May 2001 14:12:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Santiago Garcia Mantinan <manty@udc.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at inode.c:654!
In-Reply-To: <20010526193739.A2583@man.beta.es>
Message-ID: <Pine.GSO.4.21.0105261404010.413-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 May 2001, Santiago Garcia Mantinan wrote:

> Hi!
> 
> That's what my server, wich is running 2.4.5, was shouting when I pluged in
> my laptop at the console (ttyS0), all I could do was copy the output I was
> seeing on minicom to a file, after rebooting I saw that the kernel had left
> some of the logging on kern.log, so I'm attaching a file with both the stuff
> on the console and the ones on the log.
> 
> The machine is an intel pentium 166 with 48 megs of mem, it has an stock
> 2.4.5 kernel with netfilter patches for the irc NAT, even though this
> patches were working ok on 2.4.4 and don't seem to have anything to do with
> this problem, I'm recompiling an stock 2.4.5 now, just to be sure.
> 
> Well, I don't know what else to say, if I'm missing something you want to
> know, don't hesitate to ask.

Lovely... It's one of the long lists and these asserts (lines 650 and 654)
are exactly what would happen if it was corrupted at some place. OTOH, it
may be for real - i.e. real inodes in wrong state getting on the list, rather
than corrupted pointer.

