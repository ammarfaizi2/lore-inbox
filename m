Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbRBHQgo>; Thu, 8 Feb 2001 11:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbRBHQgY>; Thu, 8 Feb 2001 11:36:24 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:18449 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129130AbRBHQgR>; Thu, 8 Feb 2001 11:36:17 -0500
Date: Thu, 8 Feb 2001 12:44:22 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Pavel Machek <pavel@suse.cz>,
        Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.3.96.1010208165626.9964C-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0102081244080.25475-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Feb 2001, Mikulas Patocka wrote:

> > > The problem is that aio_read and aio_write are pretty useless for ftp or
> > > http server. You need aio_open.
> > 
> > Could you explain this? 
> 
> If the server is sending many small files, disk spends huge amount time
> walking directory tree and seeking to inodes. Maybe opening the file is
> even slower than reading it - read is usually sequential but open needs to
> seek at few areas of disk.
> 
> And if you have one-threaded server using open, close, aio_read and
> aio_write, you actually block the whole server while it is opening a
> single file. This is not how async io is supposed to work.

Ok but this is not the point of the discussion. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
