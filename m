Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130043AbRCAV0c>; Thu, 1 Mar 2001 16:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130050AbRCAV0W>; Thu, 1 Mar 2001 16:26:22 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:55026 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S130043AbRCAV0K>; Thu, 1 Mar 2001 16:26:10 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103012123.f21LNNL30827@webber.adilger.net>
Subject: Re: Hashing and directories
In-Reply-To: <3A9EB984.C1F7E499@transmeta.com> from "H. Peter Anvin" at "Mar
 1, 2001 01:05:08 pm"
To: "H. Peter Anvin" <hpa@transmeta.com>
Date: Thu, 1 Mar 2001 14:23:23 -0700 (MST)
CC: Alexander Viro <viro@math.psu.edu>, Pavel Machek <pavel@suse.cz>,
        Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@innominate.de>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes [re hashed directories]:
> I don't see there being any fundamental reason to not do such an
> improvement, except the one Alan Cox mentioned -- crash recovery --
> (which I think can be dealt with; in my example above as long as the leaf
> nodes can get recovered, the tree can be rebuilt.

Actually, with Daniel's implementation, the index blocks will be in
the same file as the directory leaf nodes, so there should be no problem
in losing leaf blocks after a crash (not more so than the current ext2
setup).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
