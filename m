Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <160396-17165>; Sun, 6 Dec 1998 02:44:17 -0500
Received: from smtp4.nwnexus.com ([206.63.63.52]:3333 "EHLO smtp4.nwnexus.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <160598-17165>; Sat, 5 Dec 1998 22:33:50 -0500
Date: Sat, 5 Dec 1998 22:07:38 -0800 (PST)
From: Tim Smith <tzs@tzs.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: atomicity
In-Reply-To: <m0zmNHr-0007U1C@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.981205215727.29256C-100000@52-a-usw.rb1.blv.nwnexus.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


On Sat, 5 Dec 1998, Alan Cox wrote:
> With ext2fs you should never need a defragmenter

Unless I've accidently run my portable (written in straight ANSI C...works on
Unix, Windows, and Mac!) file system fragmenter on it.

Basic algorithm to create a highly fragmented file on pretty much any
file system:

	while file system not full
		create random small files
	delete one of them
	open target file for writing
	while target file not fully written
		write until error
		delete one of the small files at random
	close target file
	delete all of the small random files that remain

Are there any file systems around that will manage to resist fragmentation
if subjected to that?

(No, I'm not insane.  I wrote a fragmenter so I could test a Mac background
defragmenter I wrote).

--Tim Smith


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
