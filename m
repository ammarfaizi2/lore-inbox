Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHT4X>; Thu, 8 Feb 2001 14:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129649AbRBHT4O>; Thu, 8 Feb 2001 14:56:14 -0500
Received: from zeus.kernel.org ([209.10.41.242]:37075 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129031AbRBHT4I>;
	Thu, 8 Feb 2001 14:56:08 -0500
Date: Thu, 8 Feb 2001 19:50:32 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
        Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010208195032.H9130@redhat.com>
In-Reply-To: <20010208001513.B189@bug.ucw.cz> <Pine.LNX.3.96.1010208145857.24587C-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.96.1010208145857.24587C-100000@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Thu, Feb 08, 2001 at 03:52:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 08, 2001 at 03:52:35PM +0100, Mikulas Patocka wrote:
> 
> > How do you write high-performance ftp server without threads if select
> > on regular file always returns "ready"?
> 
> No, it's not really possible on Linux. Use SYS$QIO call on VMS :-)

Ahh, but even VMS SYS$QIO is synchronous at doing opens, allocation of
the IO request packets, and mapping file location to disk blocks.
Only the data IO is ever async (and Ben's async IO stuff for Linux
provides that too).

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
