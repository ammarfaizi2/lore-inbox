Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268343AbTBYU6x>; Tue, 25 Feb 2003 15:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268344AbTBYU6x>; Tue, 25 Feb 2003 15:58:53 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:36797 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268343AbTBYU6w>; Tue, 25 Feb 2003 15:58:52 -0500
Date: Tue, 25 Feb 2003 12:53:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <417110000.1046206424@flay>
In-Reply-To: <20030225203001.GV29467@dualathlon.random>
References: <96700000.1045871294@w-hlinder>
 <20030222192424.6ba7e859.akpm@digeo.com>
 <20030225171727.GN29467@dualathlon.random>
 <20030225174359.GA10411@holomorphy.com>
 <20030225175928.GP29467@dualathlon.random>
 <20030225185008.GF10396@holomorphy.com>
 <20030225191817.GT29467@dualathlon.random> <372680000.1046201260@flay>
 <20030225203001.GV29467@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > the only solution is to do rmap lazily, i.e. to start building the rmap
>> > during swapping by walking the pagetables, basically exactly like I
>> > refill the lru with anonymous pages only after I start to need this
>> > information recently in my 2.4 tree, so if you never need to pageout
>> > heavily several giga of ram (like most of very high end numa servers),
>> > you'll never waste a single cycle in locking or whatever other
>> > worthless accounting overhead that hurts performance of all common
>> > workloads
>> 
>> Did you see the partially object-based rmap stuff? I think that does
>> very close to what you want already.
> 
> I don't see how it can optimize away the overhead but I didn't look at
> it for long.

Because you don't set up and tear down the rmap pte-chains for every 
fault in / delete of any page ... it just works off the vmas.

M.

