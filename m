Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbRBLKrY>; Mon, 12 Feb 2001 05:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129075AbRBLKrO>; Mon, 12 Feb 2001 05:47:14 -0500
Received: from [194.213.32.137] ([194.213.32.137]:23044 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129092AbRBLKqz>;
	Mon, 12 Feb 2001 05:46:55 -0500
Message-ID: <20010211223011.H3748@bug.ucw.cz>
Date: Sun, 11 Feb 2001 22:30:11 +0100
From: Pavel Machek <pavel@suse.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010208001513.B189@bug.ucw.cz> <Pine.LNX.3.96.1010208145857.24587C-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.3.96.1010208145857.24587C-100000@artax.karlin.mff.cuni.cz>; from Mikulas Patocka on Thu, Feb 08, 2001 at 03:52:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So you consider inability to select() on regular files _feature_?
> 
> select on files is unimplementable. You can't do background file IO the
> same way you do background receiving of packets on socket. Filesystem is
> synchronous. It can block. 

You can use helper friends if VFS layer is not able to handle
background IO. Then we can do it right in linux-4.4.
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
