Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310907AbSCHPJV>; Fri, 8 Mar 2002 10:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310905AbSCHPJB>; Fri, 8 Mar 2002 10:09:01 -0500
Received: from ns1.fast.net.uk ([212.42.162.2]:61195 "EHLO t2.fast.net.uk")
	by vger.kernel.org with ESMTP id <S310898AbSCHPIu>;
	Fri, 8 Mar 2002 10:08:50 -0500
Message-ID: <3C88D3F2.40807@htec.demon.co.uk>
Date: Fri, 08 Mar 2002 15:08:34 +0000
From: Christopher Quinn <cq@htec.demon.co.uk>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Christopher Quinn <cq@htec.demon.co.uk>
Subject: Interprocess shared memory .... but file backed?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I know that a combination of mmap/shmem can be used to 
achieve interprocess shared memory (notably Ralf 
Engelschall's MM library).
However as far as I can tell this is anonymous memory only.
Are there any options if one initially maps a disk file via 
mmap (in particular MAP_PRIVATE) for sharing that vm, such 
that any access by a member of the sharing process group 
will fault in the relevant file data page after which writes 
to it are seen by all?

Of course clone(2) will give the necessary sharing of page 
tables but my ideal is for sharing only of specified areas 
of vm, not everything.

Anyone know of a way of doing this?

Thanks,
Chris Quinn

PS. I'm not subscribed! please ensure you CC. me!!

