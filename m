Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSLQP4R>; Tue, 17 Dec 2002 10:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbSLQP4R>; Tue, 17 Dec 2002 10:56:17 -0500
Received: from franka.aracnet.com ([216.99.193.44]:4245 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261642AbSLQP4Q>; Tue, 17 Dec 2002 10:56:16 -0500
Message-ID: <3DFF4A3E.30204@BitWagon.com>
Date: Tue, 17 Dec 2002 08:01:02 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, Linus Torvalds wrote [regarding vsyscall implementation]:
 > The good news is that the kernel part really looks pretty clean.

Where is the CPU serializing instruction which must be executed before return
to user mode, so that kernel accesses to hardware devices are guaranteed to
complete before any subsequent user access begins?  (Otherwise a read/write
by the user to a memory-mapped device page can appear out-of-order with respect
to the kernel accesses in a preceding syscall.)  The only generally useful
serializing instructions are IRET and CPUID; only IRET is implemented univerally.

-- 
John Reiser, jreiser@BitWagon.com

