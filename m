Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261450AbREOU1S>; Tue, 15 May 2001 16:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261452AbREOU1I>; Tue, 15 May 2001 16:27:08 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:56327 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261450AbREOU06>; Tue, 15 May 2001 16:26:58 -0400
Message-ID: <3B0190F6.9D08D9CE@transmeta.com>
Date: Tue, 15 May 2001 13:26:30 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Getting FS access events
In-Reply-To: <Pine.GSO.4.21.0105151621350.21081-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> >
> > What else could it be, since it's a "struct inode *"?  NULL?
> 
> struct block_device *, for one thing. We'll have to do that as soon
> as we do block devices in pagecache.
> 

How would you know what datatype it is?  A union?  Making "struct
block_device *" a "struct inode *" in a nonmounted filesystem?  In a
devfs?  (Seriously.  Being able to do these kinds of data-structural
equivalence is IMO the nice thing about devfs & co...)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
