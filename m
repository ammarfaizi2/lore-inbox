Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbUBVBJi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 20:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUBVBJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 20:09:38 -0500
Received: from adsl-63-194-240-129.dsl.lsan03.pacbell.net ([63.194.240.129]:28421
	"EHLO mikef-fw.mikef-fw.matchmail.com") by vger.kernel.org with ESMTP
	id S261636AbUBVBJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 20:09:35 -0500
Message-ID: <4038014E.5070600@matchmail.com>
Date: Sat, 21 Feb 2004 17:09:34 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com>
In-Reply-To: <4037FCDA.4060501@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> I have 1.5 GB of ram in this system that will be a Linux Terminal Server 
>  (but using Debian & VNC).  There's 600MB+ anonymous memory, 600MB+ slab 
> cache, and 100MB page cache.  That's after turning off swap (it was 
> 400MB into swap at the time).

Here's my top slab users:

dentry_cache      585455 763395    256   15    1 : tunables  120   60 
  8 : slabdata  50893  50893      3

ext3_inode_cache  686837 688135    512    7    1 : tunables   54   27 
  8 : slabdata  98305  98305      0

buffer_head        34095  78078     48   77    1 : tunables  120   60 
  8 : slabdata   1014   1014      0

vm_area_struct     42103  44602     64   58    1 : tunables  120   60 
  8 : slabdata    769    769      0

pte_chain          20964  43740    128   30    1 : tunables  120   60 
  8 : slabdata   1458   1458      0

radix_tree_node    22494  23520    260   15    1 : tunables   54   27 
  8 : slabdata   1568   1568      0

filp               14474  15315    256   15    1 : tunables  120   60 
  8 : slabdata   1021   1021      0

nfs_inode_cache     2822   9264    640    6    1 : tunables   54   27 
  8 : slabdata   1544   1544      0

size-128            3420   4410    128   30    1 : tunables  120   60 
  8 : slabdata    147    147      0

size-32             3420   3472     32  112    1 : tunables  120   60 
  8 : slabdata     31     31      0

size-64             2823   3248     64   58    1 : tunables  120   60 
  8 : slabdata     56     56      0

proc_inode_cache    2580   3180    384   10    1 : tunables   54   27 
  8 : slabdata    318    318      0

dnotify_cache       2435   2490     20  166    1 : tunables  120   60 
  8 : slabdata     15     15      0

sock_inode_cache    1888   1981    512    7    1 : tunables   54   27 
  8 : slabdata    283    283      0

unix_sock           1682   1710    384   10    1 : tunables   54   27 
  8 : slabdata    171    171      0

inode_cache         1650   1690    384   10    1 : tunables   54   27 
  8 : slabdata    169    169      0
f

