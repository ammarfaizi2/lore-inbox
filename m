Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131899AbRDWU5K>; Mon, 23 Apr 2001 16:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131887AbRDWU5C>; Mon, 23 Apr 2001 16:57:02 -0400
Received: from ns.caldera.de ([212.34.180.1]:31753 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131899AbRDWU4y>;
	Mon, 23 Apr 2001 16:56:54 -0400
Date: Mon, 23 Apr 2001 22:56:16 +0200
Message-Id: <200104232056.WAA08894@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Cc: Alexander Viro <viro@math.psu.edu>, Christoph Rohland <cr@sap.com>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010423224505.H719@nightmaster.csn.tu-chemnitz.de>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010423224505.H719@nightmaster.csn.tu-chemnitz.de> you wrote:
> Last time we suggested this, people ended up with some OS trying
> it and getting worse performance. 

Which OS? Neither BSD nor SVR4/SVR5 (or even SVR3) do that.

> Why? You need to allocate the VFS-inode (vnode in other OSs) and
> the on-disk-inode anyway at the same time. You get better
> performance and less fragmentation, if you allocate them both
> together[1].

Because having an union in generic code that includes filesystem-specific
memebers is ugly? It's one of those a little more performance for a lot of
bad style optimizations.

	Christoph


-- 
Of course it doesn't work. We've performed a software upgrade.
Whip me.  Beat me.  Make me maintain AIX.
