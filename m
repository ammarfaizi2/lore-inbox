Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314855AbSDVWX5>; Mon, 22 Apr 2002 18:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314861AbSDVWX4>; Mon, 22 Apr 2002 18:23:56 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27339 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314855AbSDVWXz>;
	Mon, 22 Apr 2002 18:23:55 -0400
Message-ID: <3CC48D51.3050506@us.ibm.com>
Date: Mon, 22 Apr 2002 15:23:13 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: locking in sync_old_buffers
In-Reply-To: <3CC47A27.4000803@us.ibm.com> <3CC489CE.19A91699@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
 > If you're going to do this, then the BKL should be acquired
 > in fs/super.c:write_super(), so the per-fs ->write_super
 > functions do not see changed external locking rules.
 >
 > Possibly, fs/inode.c:write_inode() needs the same treatment.
 > But Doc/filesystems/Locking says that lock_kernel() is not
 > held across ->write_inode so there should be no need to take
 > it on the kupdate path.
That sounds sane.  I was just fishing for information before I go do 
anything drastic.

 > That's for 2.4.  For 2.5, we'd like sync_old_buffers to just
 > go away.   Do you have time to test
 >http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.8/everything.patch.gz
Absolutely.  What else does it contain that I should watch out for?

-- 
Dave Hansen
haveblue@us.ibm.com

