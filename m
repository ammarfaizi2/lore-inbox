Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261818AbTC0I6S>; Thu, 27 Mar 2003 03:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261820AbTC0I6S>; Thu, 27 Mar 2003 03:58:18 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:24836 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261818AbTC0I6R>; Thu, 27 Mar 2003 03:58:17 -0500
Message-ID: <3E82C05A.8080107@aitel.hist.no>
Date: Thu, 27 Mar 2003 10:11:54 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Jordi Ros <jros@xiran.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: page size bigger than 4 KB for ext2
References: <E3738FB497C72449B0A81AEABE6E713C027904@STXCHG1.simpletech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordi Ros wrote:
> Hi all,
> 
> I am trying to bring up a hard drive formated to 8KB page size using ext2. 
 > It seems that i may need to recompile the kernel, as default 
PAGE_SIZE is 4KB. I have 2 questions:
> 
> 1) What is the procedure to build a kernel that can support hard drives formatted to 8KB ext2?
Build it for one of those architectures that actually have 8k pages, and
run on that sort of machine.  Nobody has made a 8k page linux
for i386 or other 4k-page architectures.  It is possible, but a lot
of work because the cpu don't support it.

> 2) What is the procedure to format a hard drive to 8KB ext2?
 From man mke2fs:
mke2fs -b 8192 /dev/disc...

Of course you won't be able to mount it on a machine with 4k pages.

Helge Hafting

