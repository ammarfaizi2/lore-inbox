Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272081AbRIJWjd>; Mon, 10 Sep 2001 18:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272080AbRIJWjX>; Mon, 10 Sep 2001 18:39:23 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:59147 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272079AbRIJWjI>; Mon, 10 Sep 2001 18:39:08 -0400
Date: Mon, 10 Sep 2001 19:39:15 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Andreas Dilger <adilger@turbolabs.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <Pine.LNX.4.33.0109101439261.1034-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0109101937370.2490-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2001, Linus Torvalds wrote:

> (Ugly secret: because I tend to have tons of memory, I sometimes do
>
> 	find tree1 tree2 -type f | xargs cat > /dev/null

This suggests we may want to do agressive readahead on the
inode blocks.

They are small enough to - mostly - cache and should reduce
the amount of disk seeks quite a bit. In an 8 MB block group
with one 128 byte inode every 8 kB, we have a total of 128 kB
of inodes...

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

