Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQL1SZc>; Thu, 28 Dec 2000 13:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQL1SZX>; Thu, 28 Dec 2000 13:25:23 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:33522 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129267AbQL1SZO>; Thu, 28 Dec 2000 13:25:14 -0500
Date: Thu, 28 Dec 2000 15:51:24 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Chris Mason <mason@suse.com>
cc: Daniel Phillips <phillips@innominate.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <343080000.978025454@coffee>
Message-ID: <Pine.LNX.4.21.0012281551030.14052-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2000, Chris Mason wrote:

> I think a dirty page without a writepage func seems a bit
> broken.  How about we give ramfs a writepage func that just
> returns 1.  That way nobody does any special if
> (ramfs_page(page)) kinds of tests...

This will lead to the ramfs pages staying on the inactive_dirty
list forever, deadlocking the system.

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
