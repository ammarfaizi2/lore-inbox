Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266650AbSKUNmB>; Thu, 21 Nov 2002 08:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266652AbSKUNmB>; Thu, 21 Nov 2002 08:42:01 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:31378 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266650AbSKUNl7>;
	Thu, 21 Nov 2002 08:41:59 -0500
Date: Thu, 21 Nov 2002 13:47:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: L1_CACHE_SHIFT value for P4 ?
Message-ID: <20021121134721.GG9883@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andi Kleen <ak@suse.de>, Margit Schubert-While <margit@margit.com>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021121130236.00b15370@mail.dns-host.com.suse.lists.linux.kernel> <p73y97nt6fp.fsf@oldwotan.suse.de> <20021121132302.GD9883@suse.de> <20021121134250.GA31081@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121134250.GA31081@wotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 02:42:50PM +0100, Andi Kleen wrote:

 > http://developer.intel.com/technology/itj/q12001/articles/art_2.htm
 > -> "Netburst microarchitecture" -> Level 2 Instruction and Data Cache
 > "The L2 cache is organized as an 8-way set-associative cache with 128 bytes 
 > per cache line. These 128-byte cache lines consist of two 64-byte sectors. 
 > A miss in the L2 cache typically initiates two 64-byte access requests to the 
 > system bus to fill both halves of the cache line.

Ok, this makes more sense. (and sounds familiar -- probably the same
thing I was pointed to last time this came up)
 
 > It is refering to the older 256K cached P4, but I doubt they changed it.
 > Your cache reporting may refer to the 64byte sectors or is just wrong

I think its counting just the sector. It certainly makes sense.

 > (would not be the first time that has happened - some P4 versions also
 > misreported their TLB size) 

Interesting. I should go read the errata so x86info handles that correctly..

 > For cache colouring purposes you need to use the 128 byte unit.

Agreed.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
