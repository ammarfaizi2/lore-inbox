Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbSKVB5V>; Thu, 21 Nov 2002 20:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264798AbSKVB5V>; Thu, 21 Nov 2002 20:57:21 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:29381 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264797AbSKVB5T>; Thu, 21 Nov 2002 20:57:19 -0500
Message-ID: <3DDD8F4D.8080103@us.ibm.com>
Date: Thu, 21 Nov 2002 17:58:37 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.48 hangs during boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
	2.5.48 + Bill/Martin's noearlyirq patch hangs on boot on our NUMA-Q 
machines.  It boots normally up to

TCP: Hash tables configured (established 524288 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 268k freed

Then it *VERY* slowly proceeds to output a few more lines before hanging 
completely.  The lines come out one at a time, with large time delays 
between each line.  The last bit of output I get is the enabling swap line.

The -mm1 patch fixes this problem, and I'm in the process of determining 
exactly what fixes it.  Any input/ideas would be greatly appreciated.

Thanks!

-Matt

