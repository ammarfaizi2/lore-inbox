Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272519AbRIKRKv>; Tue, 11 Sep 2001 13:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272520AbRIKRKc>; Tue, 11 Sep 2001 13:10:32 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:34566 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272519AbRIKRK0>; Tue, 11 Sep 2001 13:10:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux-2.4.10-pre5
Date: Tue, 11 Sep 2001 19:17:55 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109110843010.8078-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109110843010.8078-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010911171041Z16282-1365+40@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 11, 2001 05:48 pm, Linus Torvalds wrote:
> I actually think that the "start read-ahead for inode blocks when you do
> readdir" might be a bigger win, because that would be a _new_ kind of
> read-ahead that we haven't done before, and might improve performance for
> things like "ls -l" in the cold-cache situation..
> 
> (Although again, because the inode is relatively small to the IO cache
> size, it's probably fairly _hard_ to get a fully cold-cache inode case. So
> I'm not sure even that kind of read-ahead would actually make any
> difference at all).

Having it all in cache makes a huge difference.  For:

  ls -R linux >/dev/null

it's about 5 seconds cold, about .1 second the second time.  A factor of 50!

--
Daniel
