Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129734AbQKRXpT>; Sat, 18 Nov 2000 18:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131933AbQKRXpK>; Sat, 18 Nov 2000 18:45:10 -0500
Received: from anime.net ([63.172.78.150]:52746 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S129734AbQKRXpC>;
	Sat, 18 Nov 2000 18:45:02 -0500
Date: Sat, 18 Nov 2000 15:15:28 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: bert hubert <ahu@ds9a.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 sendfile() not doing as manpage promises?
In-Reply-To: <20001119001558.B10579@home.ds9a.nl>
Message-ID: <Pine.LNX.4.30.0011181513290.5897-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000, bert hubert wrote:
> After some exploring with 'ddd' (a very nice graphical frontend for gdb,
> which includes tools to display and traverse structs), I found that this
> probably means that sendfile() can only be used to send files from
> blockdevices which support mmap()-like functionality. Is this correct?

Correct.

> In that case, the wording of the manpage needs to be changed, as it
> implies that 'either or both' of the filedescriptors can be sockets.

Its quite clear.

DESCRIPTION
       This  call copies data between file descriptor and another
       file  descriptor  or  socket.   in_fd  should  be  a  file
       descriptor   opened  for  reading.   out_fd  should  be  a
       descriptor opened for writing or a connected socket.

in_fd must be a file, out_fd can be a file or socket.

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
