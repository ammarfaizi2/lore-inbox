Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278690AbRLGMh6>; Fri, 7 Dec 2001 07:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279313AbRLGMhv>; Fri, 7 Dec 2001 07:37:51 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:37138 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S278690AbRLGMhd>; Fri, 7 Dec 2001 07:37:33 -0500
Message-ID: <3C10B7C7.6030602@namesys.com>
Date: Fri, 07 Dec 2001 15:36:23 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
        ramon@thebsh.namesys.com, yura@namesys.com
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16C2EN-0000pz-00@starship.berlin> <3C1009B8.8080300@namesys.com> <E16CCn9-0000sC-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>On December 7, 2001 01:13 am, Hans Reiser wrote:
>
>>Daniel Phillips wrote:
>>
>>>Fully understanding your code is going to take some time.  This would 
>>>go faster if I could find the papers mentioned in the comments, can you point 
>>>me at those?
>>>
>>Which papers in which comments?
>>
>
>  http://innominate.org/~graichen/projects/lxr/source/include/linux/reiserfs_fs.h?v=v2.4#L1393 
>
>  1393 create a new node.  We implement S1 balancing for the leaf nodes
>  1394 and S0 balancing for the internal nodes (S1 and S0 are defined in
>  1395 our papers.)*/
>
>--
>Daniel
>
>
How about I just explain it instead?  We preserve a criterion of nodes 
must be 50% full for internal nodes and criterion of no 3 nodes can be 
squeezed into 2 nodes for leaf nodes.

A tree that satisfies the criterion that no N nodes can be squeezed into 
N-1 nodes is an SN tree.  I don't remember where Konstantin Shvachko 
published his paper on this, maybe it can be found.

In Reiser4 we abandon the notion that fixed balancing criteria should be 
used for leaf nodes.

Hans


