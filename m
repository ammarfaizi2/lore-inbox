Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284899AbRLPXLr>; Sun, 16 Dec 2001 18:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284906AbRLPXLh>; Sun, 16 Dec 2001 18:11:37 -0500
Received: from ns01.netrox.net ([64.118.231.130]:37074 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S284899AbRLPXL0> convert rfc822-to-8bit;
	Sun, 16 Dec 2001 18:11:26 -0500
Subject: Re: Is /dev/shm needed?
From: Robert Love <rml@tech9.net>
To: =?ISO-8859-1?Q?Ra=FAl_N=FA=F1ez?= de Arenas Coronado 
	<raul@viadomus.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16FkV9-00010E-00@DervishD.viadomus.com>
In-Reply-To: <E16FkV9-00010E-00@DervishD.viadomus.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.10.08.57 (Preview Release)
Date: 16 Dec 2001 18:12:04 -0500
Message-Id: <1008544328.843.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-12-16 at 18:15, Raúl Núñez de Arenas Coronado wrote:
>     Hello Robert :)
> 
> >It is not needed.  /dev/shm mounted with tmpfs is only needed for POSIX
> >shared memory, which is still fairly rare.
>
>     That this means that I can mount more than one 'tmpfs' just like
> if it's a *real* filesystem? I wasn't sure, since it's implemented
> thru the page cache.

Yes, you can mount as many as you like.

> >It is dynamic, so you don't need to specify a size.
> 
>     Yes, I knew, I meant the maximum size. I don't want half of the
> RAM occupied just by a programming mistake ;)))

Ah, right.  Set the size to the minimum of the most RAM you can spare
and the biggest size of your tmp.  You can also specify max inode
entries, but size is probably best here.  You can pass "size=32m" or
whatever as an option.

See Documentation/filesystems/tmpfs.txt for more information.

	Robert Love

