Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271827AbRH0ShO>; Mon, 27 Aug 2001 14:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271832AbRH0ShE>; Mon, 27 Aug 2001 14:37:04 -0400
Received: from ns.cablesurf.de ([195.206.131.193]:28667 "EHLO ns.cablesurf.de")
	by vger.kernel.org with ESMTP id <S271827AbRH0Sg6>;
	Mon, 27 Aug 2001 14:36:58 -0400
Message-Id: <200108271848.UAA20391@ns.cablesurf.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 20:37:36 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva> <3B89F1FC.40F747D4@idb.hist.no> <20010827142441Z16237-32383+1641@humbolt.nl.linux.org>
In-Reply-To: <20010827142441Z16237-32383+1641@humbolt.nl.linux.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>   - Readahead cache is naturally a fifo - new chunks of readahead
>     are added at the head and unused readahead is (eventually)
>     culled from the tail.

do you really want to do this based on pages ? Should you not drop all pages 
associated with the inode that wasn't touched for the longest time ?
If you are streaming dropping all should be no great loss.

	Regards
		Oliver
