Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbUDEIT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 04:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUDEIT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 04:19:26 -0400
Received: from gprs214-14.eurotel.cz ([160.218.214.14]:53634 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262412AbUDEITZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 04:19:25 -0400
Date: Mon, 5 Apr 2004 10:19:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Ross Biro <ross.biro@gmail.com>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405081908.GB29705@elf.ucw.cz>
References: <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <2B32499D.222B761B@mail.gmail.com> <20040405081231.GB28924@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405081231.GB28924@wohnheim.fh-wedel.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Of course, it gets more interesting if you try to do it at the block
> > level instead of at the file level.  For ext2, you could just reserve
> > a block #, say -1, to mean take the data from the master cow file, and
> > anything else is treated normally.  You would need a deamon to make
> > sure you were still saving space though.
> 
> More interesting is correct.  I see the advantages and proposed this
> myself some time ago, but there are downsides.  Basically, for each
> block you need additional data, at least a counter telling you the
> number of users it currently has.  Eats up memory.
> 
> If it really has to make sense, you also have to detect duplicated
> blocks at runtime.  So you need a checksum for each block and a
> balanced tree containing those checksums or some other means of quick
> access.  Eats up 40 bytes (16 checksum, 3*8 tree pointers).  With 4k
> blocks, that's 1% memory overhead.

Well, you could do this in userspace, do it only if system is idle,
and use "scan" type approach.

But I agree that's far away.

BTW what about the "mix hardlinks with cowlinks" proposal? You said it
leads to hell and then I did not hear from you. Did it scare you that
much? ;-)
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
