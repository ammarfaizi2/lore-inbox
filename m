Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317485AbSFDMQw>; Tue, 4 Jun 2002 08:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317487AbSFDMQv>; Tue, 4 Jun 2002 08:16:51 -0400
Received: from ns.suse.de ([213.95.15.193]:12042 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317485AbSFDMQv>;
	Tue, 4 Jun 2002 08:16:51 -0400
Date: Tue, 4 Jun 2002 14:16:49 +0200
From: Andi Kleen <ak@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Caching files in nfsd was Re: [patch 12/16] fix race between writeback and unlink
Message-ID: <20020604141649.A29334@wotan.suse.de>
In-Reply-To: <1023142233.31475.23.camel@tiny.suse.lists.linux.kernel> <Pine.LNX.4.44.0206031514110.868-100000@home.transmeta.com.suse.lists.linux.kernel> <p73r8jncori.fsf_-_@oldwotan.suse.de> <15612.42635.591842.153876@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only issue that I can see (except for simple coding) is that as
> NFS cannot be precise about closing at the *right* time we would be
> changing from closing too early (and so re-opening) to closing too
> late.
> Would this be an issue for any filesystem?  My feeling is not, but I'm
> open to opinions....

The only potential issue I see is that forcing a flush when the file system
fills up may be a good idea to drop preallocations (but then one would hope 
that a fs with preallocation does this already automatically, so it hopefully 
won't be needed in nfsd) 

-Andi

