Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVIEUC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVIEUC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 16:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVIEUC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 16:02:28 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:50094
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S932454AbVIEUC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 16:02:27 -0400
Date: Mon, 5 Sep 2005 15:58:49 -0400
From: Sonny Rao <sonny@burdell.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Michael Ellerman <michael@ellerman.id.au>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes. Also some X trouble.
Message-ID: <20050905195849.GA8683@kevlar.burdell.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <Pine.LNX.4.58.0508221034090.3317@g5.osdl.org> <200508301007.11554@bilbo.math.uni-mannheim.de> <200509050949.38842@bilbo.math.uni-mannheim.de> <Pine.LNX.4.58.0509050117310.5316@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509050117310.5316@evo.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 01:45:28AM -0700, Linus Torvalds wrote:
> 
> On Mon, 5 Sep 2005, Rolf Eike Beer wrote:
> > 
> > The problem appeared between 2.6.12-git3 and 2.6.12-git4.
> 
> Just for reference, that's git ID's
> 
>  1d345dac1f30af1cd9f3a1faa12f9f18f17f236e..2a5a68b840cbab31baab2d9b2e1e6de3b289ae1e
> 
> and that's 225 commits and the diff is 55,781 lines long.
> 
> It would be very good if you could try to use raw git and narrow it down a 
> bit more. It's really easy these days with a recent git version, just do
> 
> 	git bisect start
> 	git bisect good 1d345dac1f30af1cd9f3a1faa12f9f18f17f236e
> 	git bisect bad 2a5a68b840cbab31baab2d9b2e1e6de3b289ae1e
> 
> and off you go.. That will select a new kernel for you to try, which
> basically cuts down the commits to ~110 - and if you can test just a few 
> kernels and binary-search a bit more, we'd have it down to just a couple.

Can this method detect breakages that are spread across more than one
patch? I suppose it'll just trigger on the last patch commited in the
set in this case?   

Sonny
