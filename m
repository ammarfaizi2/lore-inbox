Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbUCOS7L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbUCOS7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:59:11 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:5789 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262699AbUCOS7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:59:08 -0500
Message-ID: <4055FC8D.9020908@BitWagon.com>
Date: Mon, 15 Mar 2004 10:57:17 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mpm@selenic.com
Subject: [PATCH] [CFT] elfdiet reduces binfmt_elf
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The elfdiet patch reduces code space and time in the handling of execve()
for binfmt_elf executables.  On x86 the net savings is about 1100 bytes
in size (11% of fs/binfmt_elf.o) and 2.5% in time.  Also, each Elf_Phdr
gets its own .bss as appropriate, including p_flags access permissions.
This can be used by programs such as Wine to reserve address space with
no memory commit charge.

As of March 15, the patch is BETA test quality; I run it in all the time
in normal use on i686 FC2test1.   Please test and report, especially
64-bit machines.

http://www.BitWagon.com/elfdiet/elfdiet.html    description and links

http://www.BitWagon.com/elfdiet/elfdiet-2.6.4.patch.gz  (9KB)
http://www.BitWagon.com/elfdiet/elfdiet-2.6.3-2.1.253.patch.gz  (9KB;
      Fedora Core 2 Test 1)

-- 


