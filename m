Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262880AbVCDM2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbVCDM2h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbVCDM13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:27:29 -0500
Received: from smartmx-02.inode.at ([213.229.60.34]:64177 "EHLO
	smartmx-02.inode.at") by vger.kernel.org with ESMTP id S262905AbVCDMXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 07:23:46 -0500
Message-ID: <42285354.5090900@inode.info>
Date: Fri, 04 Mar 2005 13:23:48 +0100
From: Richard Fuchs <richard.fuchs@inode.info>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: slab corruption in skb allocs
References: <42283093.7040405@inode.info> <20050304035309.1da7774e.akpm@osdl.org>
In-Reply-To: <20050304035309.1da7774e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> I guess it could be hardware.  But given that disabling DMA _causes_ the
> problem, rather than fixes it, it seems unlikely.
> 
> Could you enable CONFIG_DEBUG_PAGEALLOC in .config and see it that triggers
> an oops?

by now, i could reproduce this on two different machines with quite 
different hardware, while a third doesn't seem to show those symptoms. 
on the second machine, i got the corruption errors from the slab 
debugger mostly from the disk access alone, the network traffic was only 
minimal (but still present). i was doing write operations on the hdd in 
this test.

kernel 2.6.7 doesn't show this behavior, while all kernels from 2.6.9 
and up do. (i didn't test 2.6.8.x).

as for DEBUG_PAGEALLOC... when i enable this option, the errors from 
DEBUG_SLAB magically disappear. however, my ssh session got disconnected 
once while doing the disk access with the message:

Received disconnect from 195.58.172.154: 2: Bad packet length 4239103034.

never seen this before and not sure if this has anything to do with it...

cheers
richard
