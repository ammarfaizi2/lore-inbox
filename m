Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137211AbREKSv6>; Fri, 11 May 2001 14:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137210AbREKSvs>; Fri, 11 May 2001 14:51:48 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:40458 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S137209AbREKSvd>;
	Fri, 11 May 2001 14:51:33 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105111850.f4BIolB503014@saturn.cs.uml.edu>
Subject: Re: [reiserfs-dev] Re: reiserfs, xfs, ext2, ext3
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 11 May 2001 14:50:47 -0400 (EDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hps@intermeta.de,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <3AFBC643.42631F5C@namesys.com> from "Hans Reiser" at May 11, 2001 04:00:20 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:

> Tell us what to code for, and so long as it doesn't involve looking
> up files by their 32 bit inode numbers we'll probably be happy to
> code to it.  The Neil Brown stuff is already coded for though.

Next time around, when you update the on-disk format, how about
allowing for such a thing?

You could have a tree that maps from inode number to whatever
you need to find a file. This shouldn't affect much more than
file creation and deletion. Maybe it will allow for a more
robust fsck as well, helping to justify the cost.

It would be really nice to be able to find all filenames that
refer to a given inode number.
