Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272558AbRIKUH0>; Tue, 11 Sep 2001 16:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272559AbRIKUHR>; Tue, 11 Sep 2001 16:07:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:21522 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272558AbRIKUHD>; Tue, 11 Sep 2001 16:07:03 -0400
Date: Tue, 11 Sep 2001 17:07:01 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010911095541Z16308-26183+1020@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0109111706140.12797-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2001, Daniel Phillips wrote:

> I tested this idea by first doing a ls -R on the tree, then
> Linus's find command:
>
>     time ls -R linux >/dev/null
>     time find linux -type f | xargs cat > /dev/null

> According to your theory the total time for the two commands
> should be less than the second command alone.  But it wasn't,
> the two commands together took almost exactly the same time as
> the second command by itself.

Well DUH, your first find isn't doing any readahead on the
inodes either.

> There goes that theory.

You might want to test it first.

cheers,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

