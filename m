Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267430AbTBDTeZ>; Tue, 4 Feb 2003 14:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTBDTeZ>; Tue, 4 Feb 2003 14:34:25 -0500
Received: from netrealtor.ca ([216.209.85.42]:13316 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S267430AbTBDTeY>;
	Tue, 4 Feb 2003 14:34:24 -0500
Date: Tue, 4 Feb 2003 14:52:04 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Fiona Sou-Yee Wong <wongfs@cs.ucdavis.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: disabling nagle
Message-ID: <20030204195204.GA1626@mark.mielke.cc>
References: <Pine.LNX.4.44.0302041138070.2629-100000@pc6.cs.ucdavis.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302041138070.2629-100000@pc6.cs.ucdavis.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 11:39:16AM -0800, Fiona Sou-Yee Wong wrote:
> I have kernel version 2.4.18 and I was looking for a patch to have the 
> option to disable NAGLE's algorithm.
> Is there a patch available for kernels 2.4 and greater and if not, what 
> other options do I have?

Don't patch the kernel for something like this.

Use setsockopt(TCP_NODELAY) on the TCP/IP socket file descriptors of
your choice.

Read "man tcp".

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

