Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbSKVCHT>; Thu, 21 Nov 2002 21:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265034AbSKVCHT>; Thu, 21 Nov 2002 21:07:19 -0500
Received: from holomorphy.com ([66.224.33.161]:10884 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264992AbSKVCHS>;
	Thu, 21 Nov 2002 21:07:18 -0500
Date: Thu, 21 Nov 2002 18:11:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.48 hangs during boot
Message-ID: <20021122021131.GW23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org
References: <3DDD8F4D.8080103@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDD8F4D.8080103@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 05:58:37PM -0800, Matthew Dobson wrote:
> Hello all,
> 	2.5.48 + Bill/Martin's noearlyirq patch hangs on boot on our NUMA-Q 
> machines.  It boots normally up to
> TCP: Hash tables configured (established 524288 bind 65536)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 268k freed
> Then it *VERY* slowly proceeds to output a few more lines before hanging 
> completely.  The lines come out one at a time, with large time delays 
> between each line.  The last bit of output I get is the enabling swap line.
> The -mm1 patch fixes this problem, and I'm in the process of determining 
> exactly what fixes it.  Any input/ideas would be greatly appreciated.
> Thanks!
> -Matt

get the axboe/akpm fixes for the elevator deadlock and/or an intermediate
bk tree. This is an io scheduling issue.


Bill
