Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbRBHRA2>; Thu, 8 Feb 2001 12:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129067AbRBHRAS>; Thu, 8 Feb 2001 12:00:18 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:32239 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129130AbRBHRAF>; Thu, 8 Feb 2001 12:00:05 -0500
Date: Thu, 8 Feb 2001 14:57:26 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>, Pavel Machek <pavel@suse.cz>,
        Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.3.96.1010208165626.9964C-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0102081456030.2378-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Mikulas Patocka wrote:

> > > You need aio_open.
> > Could you explain this? 
> 
> If the server is sending many small files, disk spends huge
> amount time walking directory tree and seeking to inodes. Maybe
> opening the file is even slower than reading it

Not if you have a big enough inode_cache and dentry_cache.

OTOH ... if you have enough memory the whole async IO argument
is moot anyway because all your files will be in memory too.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
