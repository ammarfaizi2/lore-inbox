Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129160AbRBHP5f>; Thu, 8 Feb 2001 10:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129297AbRBHP50>; Thu, 8 Feb 2001 10:57:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34830 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129160AbRBHP5Q>;
	Thu, 8 Feb 2001 10:57:16 -0500
Date: Thu, 8 Feb 2001 16:55:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>, Pavel Machek <pavel@suse.cz>,
        Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010208165529.E3262@suse.de>
In-Reply-To: <Pine.LNX.4.21.0102081000450.25219-100000@freak.distro.conectiva> <Pine.LNX.3.96.1010208164448.9024C-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1010208164448.9024C-100000@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Thu, Feb 08, 2001 at 04:46:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08 2001, Mikulas Patocka wrote:
> > Even async IO (ie aio_read/aio_write) should block on the request queue if
> > its full in Linus mind.
> 
> This is not problem (you can create queue big enough to handle the load).

Well in theory, but in practice this isn't a very good idea. At some
point throwing yet more requests in there doesn't make a whole lot
of sense. You are basically _always_ going to be able to empty the request
list by dirtying lots of data.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
