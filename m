Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265439AbSKFAVo>; Tue, 5 Nov 2002 19:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265441AbSKFAVn>; Tue, 5 Nov 2002 19:21:43 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:23294 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265439AbSKFAVk>; Tue, 5 Nov 2002 19:21:40 -0500
Date: Tue, 05 Nov 2002 17:23:17 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: bert hubert <ahu@ds9a.nl>
cc: Peter Chubb <peter@chubb.wattle.id.au>, jw schultz <jw@pegasys.ws>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <32290000.1036545797@flay>
In-Reply-To: <20021106001007.GA15200@outpost.ds9a.nl>
References: <15816.19206.959160.739312@wombat.chubb.wattle.id.au> <26610000.1036541181@flay> <20021105231649.GA14511@outpost.ds9a.nl> <27920000.1036544267@flay> <20021106001007.GA15200@outpost.ds9a.nl>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Errm... we have profiled it. Look at the subject line ... this started
>> off as a dcache_rcu discussion. The dcache lookup ain't cheap, for 
>> starters, but that's not really the problem ... it's O(number of tasks),
>> which sucks.
> 
> Ok - but if opening a few files is the problem, the solution is not to roll
> those files into one but to figure out why opening the files is slow in the
> first place.

It's not a few files if you have large numbers of tasks. It's an 
interface that fundamentally wasn't designed to scale, and futzing
around tweaking the thing isn't going to cut it, it needs a different
design. I'm not proposing throwing out any of the old simple interfaces,
just providing something efficient as a data gathering interface for
those people who wish to use it.

M.

