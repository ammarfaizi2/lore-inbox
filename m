Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTLJMD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 07:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTLJMD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 07:03:58 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:58251 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262111AbTLJMD4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 07:03:56 -0500
From: Vitaly Fertman <vitaly@namesys.com>
Organization: NAMESYS
To: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org
Subject: Re: forwarded message from Jan De Luyck
Date: Wed, 10 Dec 2003 16:04:15 +0300
User-Agent: KMail/1.5.1
References: <16343.2023.525418.637117@laputa.namesys.com>
In-Reply-To: <16343.2023.525418.637117@laputa.namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312101604.15299.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

> Hello,
>
> Today I discovered this in my syslogs, after something strange
> happening to XFree86 (hung at startup, then dumped me back to the console)
>
> is_leaf: free space seems wrong: level=1, nr_items=41, free_space=65224
> rdkey vs-5150: search_by_key: invalid format found in block 283191. Fsck?
> vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find
> stat data of [11 12795 0x0 SD] is_leaf: free space seems wrong: level=1,
> nr_items=41, free_space=65224 rdkey vs-5150: search_by_key: invalid format
> found in block 283191. Fsck? vs-13070: reiserfs_read_locked_inode: i/o
> failure occurred trying to find stat data of [11 12798 0x0 SD]

this all about fs corruptions. fsck is needed.

> I've never seen these before, and I've been digging through my syslogs but
> am unable to find any other references of this.
> Does this mean the disk is dying? Or just the filesystem is corrupt?
> Unfortunately, I'm not able to rebuild the tree at this time because I
> haven't got a 'rescue' disk with me and the errors are on my root
> partition...
>
> Any other pointers?

reiserfsck from the 3.6.12-pre1 package is able to recover mounted ro 
partitions.

--
Thanks,
Vitaly Fertman
