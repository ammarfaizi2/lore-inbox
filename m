Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261342AbSIZAEr>; Wed, 25 Sep 2002 20:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSIZAEr>; Wed, 25 Sep 2002 20:04:47 -0400
Received: from holomorphy.com ([66.224.33.161]:29346 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261342AbSIZAEq>;
	Wed, 25 Sep 2002 20:04:46 -0400
Date: Wed, 25 Sep 2002 17:08:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, riel@surriel.com,
       willy@debian.org
Subject: Re: [2.5.38] file_lock_cache leak
Message-ID: <20020926000852.GI3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Simon Kirby <sim@netnation.com>, linux-kernel@vger.kernel.org,
	akpm@zip.com.au, riel@surriel.com, willy@debian.org
References: <20020925161431.GA13576@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020925161431.GA13576@netnation.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 09:14:31AM -0700, Simon Kirby wrote:
> I was wondering why my box was getting slower and slower... :)
> I'm running galeon, mutt, rxvts, etc... Nothing very special.
> file_lock_cache   1568120 1568120     96 39203 39203    1 :  252  126

I'm seeing unusual file_lock space consumption here as well. I think
after running bk (which may exercise it) the memory becomes immortal.

The usual tiobench run:
       buffer_head:   149047KB   149047KB  100.0 
   file_lock_cache:    50818KB    50818KB  100.0 
  ext2_inode_cache:    41599KB    41603KB   99.99
       task_struct:    27433KB    27433KB  100.0 
   radix_tree_node:    23498KB    23498KB  100.0 
       names_cache:    22368KB    22372KB   99.98
      dentry_cache:     2327KB     9026KB   25.78
    vm_area_struct:     3510KB     3510KB  100.0 
         size-1024:     3406KB     3468KB   98.21
         biovec-64:     2534KB     3206KB   79.4 


Cheers,
Bill
