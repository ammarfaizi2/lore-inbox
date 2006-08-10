Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161443AbWHJQqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161443AbWHJQqp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbWHJQqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:46:45 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:55256 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161434AbWHJQqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:46:44 -0400
Message-ID: <44DB62EE.3050801@us.ibm.com>
Date: Thu, 10 Aug 2006 09:46:38 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/9] extents for ext4
References: <1155172827.3161.80.camel@localhost.localdomain> <20060809233940.50162afb.akpm@osdl.org>
In-Reply-To: <20060809233940.50162afb.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> On Wed, 09 Aug 2006 18:20:26 -0700
> Mingming Cao <cmm@us.ibm.com> wrote:
> 
> 
>>Add extent map support to ext4. Patch from Alex Tomas.
>>
>>On disk extents format:
>>/*
>>  * this is extent on-disk structure
>>  * it's used at the bottom of the tree
>>  */
>>struct ext3_extent {
>>        __le32  ee_block;       /* first logical block extent covers */
>>        __le16  ee_len;         /* number of blocks covered by extent */
>>        __le16  ee_start_hi;    /* high 16 bits of physical block */
>>        __le32  ee_start;       /* low 32 bigs of physical block */
>>};
>>
> 
> 
>>From a quick scan:
> 

> - There are several places which appear to be putting block numbers into
>   an `int'.
> 

This is fixed in [PATCH 4/9] 48bit support in extents, where we 
converted those "int" type block numbers to ext4_fsblk_t (which is 
typedefined as sector_t to support 48bit)

Thanks,
Mingming

