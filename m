Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288960AbSATUDq>; Sun, 20 Jan 2002 15:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSATUDh>; Sun, 20 Jan 2002 15:03:37 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:41197 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S288960AbSATUDS>; Sun, 20 Jan 2002 15:03:18 -0500
Date: Sun, 20 Jan 2002 22:02:55 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
Message-ID: <20020120200255.GG135220@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain> <Pine.LNX.3.95.1020118163838.3008B-100000@chaos.analogic.com> <a2afsg$73g$2@ncc1701.cistron.net> <20020120152359.B326@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020120152359.B326@localhost>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 03:23:59PM +0100, you [Remi Turk] claimed:
>
> Which I actually posted a patch for in 2.4.0-test1 time :)
> 
> % ll -i old
> 32619 -rw-r--r--   1 remi     users          14 Jul 31 15:44 old
> % exec 5<old
> % rm old
> % ~/src/flink/flink 5 new
> % ll -i new
> 32619 -rw-r--r--   1 remi     users          14 Jul 31 15:44 new
> 
> The more interesting part - open(O_ANONYMOUS) or something like
> that looked much harder to do. (IOW, I gave up ;) )

Just out of interest (I'm not actually suggesting this would be useful, or
feasible): what about ilink(dev, inode_nr, "path") or iopen(dev, inode_nr)?

Or /proc/inodes/dev/<nr> ?



-- v --

v@iki.fi
