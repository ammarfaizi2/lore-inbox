Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVCHUep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVCHUep (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVCHUa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:30:28 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:64729 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S262113AbVCHU2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 15:28:15 -0500
Date: Tue, 8 Mar 2005 12:27:57 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] crash after fsync causing serious FS corruptions (ext2,
 2.6.11)
In-Reply-To: <20050308123109.GA7005@thunk.org>
Message-ID: <Pine.GSO.4.44.0503081212180.1669-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe the warning should go away if you mount -o sync (but then
> the filesystem will perform very slowly :-).
>

I do agree with you, Andreas and other ppl on that this is expected
behavior on ext2, and ext3 should be chosen over ext2 when such
corruptions are under consideration.

However, mount -o sync won't fix the problem for ext2 either :)  I sent a
report last week about that ext2 doesn't actually sync writes even if an
ext2 partition is mounted -o sync,dirsync.  Andrew confirmed that ext2 has
MS_SYNCHONOUS holes (and possibly O_SYNC holes).

check out http://www.uwsg.iu.edu/hypermail/linux/kernel/0503.0/1252.html
or google "Junfeng mount sync".

Thanks,
-Junfeng

