Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132326AbRDWWAb>; Mon, 23 Apr 2001 18:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132327AbRDWWAV>; Mon, 23 Apr 2001 18:00:21 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:4777 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S132326AbRDWWAL>; Mon, 23 Apr 2001 18:00:11 -0400
Date: Tue, 24 Apr 2001 00:00:09 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Alexander Viro <viro@math.psu.edu>, Christoph Rohland <cr@sap.com>,
        "David L. Parsley" <parsley@linuxjedi.org>, lm@bitmover.org,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
Message-ID: <20010424000008.J719@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010423224505.H719@nightmaster.csn.tu-chemnitz.de> <200104232056.WAA08894@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200104232056.WAA08894@ns.caldera.de>; from hch@ns.caldera.de on Mon, Apr 23, 2001 at 10:56:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 10:56:16PM +0200, Christoph Hellwig wrote:
> In article <20010423224505.H719@nightmaster.csn.tu-chemnitz.de> you wrote:
> > Last time we suggested this, people ended up with some OS trying
> > it and getting worse performance. 
> 
> Which OS? Neither BSD nor SVR4/SVR5 (or even SVR3) do that.

Don't remember. I think Larry McVoy told the story, so I cc'ed
him ;-)

> Because having an union in generic code that includes filesystem-specific
> memebers is ugly? It's one of those a little more performance for a lot of
> bad style optimizations.

We have this kind of stuff all over the place. If we allocate
some small amount of memory and and need some small amount
associated with this memory, there is no problem with a little
waste.

Waste is better than fragmentation. This is the lesson people
learned from segments in the ia32.

Objects are easier to manage, if they are the same size.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
