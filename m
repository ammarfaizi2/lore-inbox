Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUCaOpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 09:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUCaOpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 09:45:52 -0500
Received: from gprs213-129.eurotel.cz ([160.218.213.129]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261987AbUCaOpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 09:45:50 -0500
Date: Wed, 31 Mar 2004 16:45:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040331144536.GA328@elf.ucw.cz>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040331143412.GA18990@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331143412.GA18990@mail.shareable.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Also it should be possible to have file with 2 hardlinks cowlinked
> > somewhere, and possibly make more hardlinks of that one... Having
> > pointer to another inode in place where direct block pointers normally
> > are should be enough (thinking ext2 here).
> 
> Yes.
> 
> > > But sharing data blocks without sharing inodes is too horrible even to
> > > contemplate, I suppose.
> > 
> > Why, btw?
> > 
> > Lets say we allocate 4 bits instead of one for block bitmap. Count
> > "15" is special, now it means "15 or higher". That means we have to
> > "garbage-collect" to free space that used to have more than 15 links,
> > but that should not happen too often...
> 
> The garbage collection is what's horrible about it :)
> Btw, 15 would be exceeded easily in my home directory.

Well, but chances are that you'll never unlink such files... Leaving
garbage collection to fsck would make it rather easy.

> IMHO, an inode whose block pointers points to another, so that whole
> files only can be shared, would be fine.

Yes, this is probably way better way to do that.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
