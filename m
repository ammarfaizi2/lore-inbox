Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTLJUCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 15:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbTLJUCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 15:02:17 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:33696 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263937AbTLJUCQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 15:02:16 -0500
From: Vitaly Fertman <vitaly@namesys.com>
Organization: NAMESYS
To: Hans Reiser <reiser@namesys.com>
Subject: Re: forwarded message from Jan De Luyck
Date: Thu, 11 Dec 2003 00:02:29 +0300
User-Agent: KMail/1.5.1
Cc: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org
References: <16343.2023.525418.637117@laputa.namesys.com> <200312101604.15299.vitaly@namesys.com> <3FD77A0E.7000909@namesys.com>
In-Reply-To: <3FD77A0E.7000909@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312110002.29307.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 22:54, Hans Reiser wrote:
> Vitaly Fertman wrote:
> >Hello,
> >
> >>Hello,
> >>
> >>Today I discovered this in my syslogs, after something strange
> >>happening to XFree86 (hung at startup, then dumped me back to the
> >> console)
> >>
> >>is_leaf: free space seems wrong: level=1, nr_items=41, free_space=65224
> >>rdkey vs-5150: search_by_key: invalid format found in block 283191. Fsck?
> >>vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find
> >>stat data of [11 12795 0x0 SD] is_leaf: free space seems wrong: level=1,
> >>nr_items=41, free_space=65224 rdkey vs-5150: search_by_key: invalid
> >> format found in block 283191. Fsck? vs-13070:
> >> reiserfs_read_locked_inode: i/o failure occurred trying to find stat
> >> data of [11 12798 0x0 SD]
> >
> >this all about fs corruptions. fsck is needed.
>
> is this a failure due to bad sector on the drive?

No, we return EIO in many places if some data corruption is found 
even if the hardware has worked ok. A stat data has not been found
here and EIO is returned.

--
Thanks,
Vitaly Fertman
