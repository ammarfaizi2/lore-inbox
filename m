Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262625AbTDAQNd>; Tue, 1 Apr 2003 11:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262629AbTDAQNc>; Tue, 1 Apr 2003 11:13:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:6872 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262625AbTDAQNb>;
	Tue, 1 Apr 2003 11:13:31 -0500
Date: Tue, 1 Apr 2003 21:59:57 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Filesystem aio rdwr patchset 
Message-ID: <20030401215957.A1800@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have taken a first pass at implementing the write path
for filesystem aio. 

Attached as a response to this mail is the full 
patchset for filesystem aio (retry based model) including 
read and write paths.

01aioretry.patch : this is the common generic aio
  retry code
02aiordwr.patch  : this is the filesystem read+write
  changes for aio using the retry model

03aiobread.patch : code for async breads which can
  be used by filesystems for providing async get block 
  implementation
04ext2-aiogetblk.patch :  an async get block 
  implementation for ext2

I would really appreciate comments and review feedback 
from the perspective of fs developers especially on
the latter 2 patches in terms of whether this seems a 
sound approach or if I'm missing something very crucial
(which I just well might be)
Is this easy to do for other filesystems as well ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

