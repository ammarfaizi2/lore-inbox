Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbTCOVzu>; Sat, 15 Mar 2003 16:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbTCOVzt>; Sat, 15 Mar 2003 16:55:49 -0500
Received: from holomorphy.com ([66.224.33.161]:33747 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261613AbTCOVzr>;
	Sat, 15 Mar 2003 16:55:47 -0500
Date: Sat, 15 Mar 2003 14:06:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent inode allocation for ext2 against 2.5.64
Message-ID: <20030315220618.GY20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <m365qk1gzx.fsf@lexa.home.net> <20030315135158.6d5fef1a.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030315135158.6d5fef1a.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Alex Tomas wrote:
>>  struct ext2_bg_info {
>>  	u8 debts;
>>  	spinlock_t balloc_lock;
>> +	spinlock_t ialloc_lock;
>>  	unsigned int reserved;
>>  } ____cacheline_aligned_in_smp;

On Sat, Mar 15, 2003 at 01:51:58PM -0800, Andrew Morton wrote:
> hm, I wonder if this should be in a separate cacheline.  We may as well use a
> single lock if they're this close together.  Bill, can you test that
> sometime?

Benching now.


-- wli
