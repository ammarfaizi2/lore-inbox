Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316992AbSFWH56>; Sun, 23 Jun 2002 03:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316993AbSFWH55>; Sun, 23 Jun 2002 03:57:57 -0400
Received: from [213.23.20.201] ([213.23.20.201]:16579 "EHLO starship")
	by vger.kernel.org with ESMTP id <S316992AbSFWH55>;
	Sun, 23 Jun 2002 03:57:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Date: Sun, 23 Jun 2002 09:57:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>,
       Christopher Li <chrisl@gnuchina.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
References: <20020619113734.D2658@redhat.com> <E17Lryk-0002zF-00@starship> 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17M2FA-00046y-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 June 2002 02:01, Daniel Phillips wrote:
> On Saturday 22 June 2002 22:59, Daniel Phillips wrote:
> > ... The directory started at 385024 bytes (38.5 bytes/entry 
> > and grew a block after about 300 steady state remove/create cycles.   Another 
> > block was added around 500 cycles.  It's up to 1100 cycles now, and hasn't 
> > added another block.  It sort of looks like the expansion is getting slower.  
> > This is with dx_hack_hash.  I'll let it run overnight to get a feeling of how 
> > urgent the steady-state problem is.
> 
> And now it's up to 5500 cycles, and still hasn't added another block.
> Empirically, we're seeing a very steep falloff in the expansion rate,
> though I'll readily admit the testing is far from sufficient.

At the end of the overnight run with about 16,600 cycles another block has
been added, bringing the directory up to 397312 bytes.  The four points I
have now make a nice logarithmic curve, i.e., the slope seems to fall off so
rapidly that there is not a lot to worry about here.  All the same, I should
code a more efficient test and run a few billion cycles.  Or perhaps that
same effort would be better spent working on the coalesce, which will turn
this into a moot point.

-- 
Daniel
