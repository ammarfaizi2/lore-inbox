Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282206AbRKWTDX>; Fri, 23 Nov 2001 14:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282207AbRKWTDN>; Fri, 23 Nov 2001 14:03:13 -0500
Received: from [213.97.199.90] ([213.97.199.90]:2176 "HELO fargo")
	by vger.kernel.org with SMTP id <S282206AbRKWTDI> convert rfc822-to-8bit;
	Fri, 23 Nov 2001 14:03:08 -0500
From: "David =?ISO-8859-1?Q?G=F3mez" ?= <davidge@jazzfree.com>
Date: Fri, 23 Nov 2001 20:02:28 -0500 (EST)
X-X-Sender: <huma@fargo>
To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <dervishd@jazzfree.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Moving ext3 journal file
In-Reply-To: <E167Fuw-00001K-00@DervishD>
Message-ID: <Pine.LNX.4.33.0111231944430.2891-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi ;),

>     Is there any problem on moving the /.journal file (even renaming
> it) so it doesn't lives on the root? I mean, maintaining its inode
> number, of course ;))
>
>     Anyway, ext3 shouldn't (just an idea) show the journal as a
> normal file. It may add some load on the kernel, because the inode
> number should be compared with that of the journal every time a file
> is accessed, but it's just a suggestion ;))

AFAIK the .journal it's visible only when you convert an ext2 to an ext3
filesystem on a mounted partition, it was a problem with 2.4.10 kernel
version, but i'm not sure if posterior releases also show this behavior.
Anyway you can solve it recreating a new journal (remount it to ext2
before doing this):

'chattr -i /.journal;rm /.journal;tune2fs -j /dev/whatever'



David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


