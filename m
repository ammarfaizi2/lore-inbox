Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319290AbSIFR2b>; Fri, 6 Sep 2002 13:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319292AbSIFR2b>; Fri, 6 Sep 2002 13:28:31 -0400
Received: from dsl-213-023-039-069.arcor-ip.net ([213.23.39.69]:26800 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319290AbSIFR16>;
	Fri, 6 Sep 2002 13:27:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Anton Altaparmakov <aia21@cantab.net>, "Peter T. Breuer" <ptb@it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
Date: Fri, 6 Sep 2002 19:33:55 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, Xavier Bestel <xavier.bestel@free.fr>,
       david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.SOL.3.96.1020906164920.7282A-100000@virgo.cus.cam.ac.uk>
In-Reply-To: <Pine.SOL.3.96.1020906164920.7282A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17nMzU-0006I3-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 September 2002 19:20, Anton Altaparmakov wrote:
> As of very recently, Andrew Morton introduced an optimization to this with
> the get_blocks() interface in 2.5 kernels. Now the file system, when doing
> direct_IO at least, returns to the VFS the requested block position _and_
> the size of the block. So the VFS now gains in power in that it only needs
> to ask for each block once as it is now aware of the size of the block.
> 
> But still, even with this optimization, the VFS still asks the FS for each
> block, and then the FS has to lookup each block.

Well, it takes no great imagination to see the progression: get_blocks
acts on extents instead of arrays of blocks.  Expect to see that around
the 2.7 timeframe.

-- 
Daniel
