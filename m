Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131420AbQKCTeL>; Fri, 3 Nov 2000 14:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131443AbQKCTeB>; Fri, 3 Nov 2000 14:34:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36882 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131420AbQKCTdl>; Fri, 3 Nov 2000 14:33:41 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ext3 vs. JFS file locations...
Date: 3 Nov 2000 11:33:10 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8tv3tm$iqg$1@cesium.transmeta.com>
In-Reply-To: <3A02D150.E7E87398@usa.net> <200011031725.eA3HPwP12932@webber.adilger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200011031725.eA3HPwP12932@webber.adilger.net>
By author:    Andreas Dilger <adilger@turbolinux.com>
In newsgroup: linux.dev.kernel
>
> Michael Boman writes:
> > It seems like both IBM's JFS and ext3 wants to use fs/jfs .. IMHO that
> > is like asking for problem.. A more logic location for ext3 should be
> > fs/ext3, no?
> 
> Actually, if you would look in linux/fs, you will see that ext3 IS in
> linux/fs/ext3.  However, there is a second component to ext3, which is
> a generic block journalling layer which is called jfs.  This journal
> layer is designed so that it isn't ext3 specific, so it would be
> _possible_ for other journalling filesystems to use it.  Whether non-ext3
> filesystems will actually use it is another question (actually the
> InterMezzo distributed filesystem uses the ext3-jfs functionality to
> do compound transactions on disk to ensure cluster coherency).
> 
> I think that Stephen at one time said he would change the name, but I
> guess he has not done so yet.
> 

How about naming it something that doesn't end in -fs, such as
"journal" or "jfsl" (Journaling Filesystem Layer?)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
