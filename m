Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273946AbRIRV2l>; Tue, 18 Sep 2001 17:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273944AbRIRV2c>; Tue, 18 Sep 2001 17:28:32 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:43178 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273939AbRIRV2Z>; Tue, 18 Sep 2001 17:28:25 -0400
Date: Tue, 18 Sep 2001 14:22:44 -0700
From: Brian Beattie <bbeattie@sequent.com>
To: Ingo Molnar <mingo@elte.hu>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] multipath RAID personality, 2.4.10-pre9
Message-ID: <20010918142241.A2866@dyn9-47-16-223.des.beaverton.ibm.com>
In-Reply-To: <20010916150806.E1541@turbolinux.com> <Pine.LNX.4.33.0109170113010.3960-100000@localhost.localdomain> <20010918203946.A12814@wyvern>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010918203946.A12814@wyvern>; from adrian.bridgett@iname.com on Tue, Sep 18, 2001 at 08:39:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 08:39:46PM +0100, Adrian Bridgett wrote:
> On Mon, Sep 17, 2001 at 01:16:56 +0200 (+0000), Ingo Molnar wrote:
> [snip]
> > > [...] Also, it is my understanding that with some multipath hardware,
> > > if you read from the "backup" path it will kill access to the primary
> > > path (this can be used when more than one system access shared disk
> > > for failover).  As a result, we should always read from the "primary"
> > > path for each disk unless there is an error.
> > 
> > yes, and this is being done currently, only the primary path is used.
> 
> Do you have plans to change this?  I know that the SDD software for AIX load
> balances between paths (and I think EMC's Powerpaths do for AIX too), DMP
> (from Veritas) for Solaris doesn't.
> 

I have been working with the version of this code included in RH 7.1.
I have code that does round robin routing.  I'm working on cleaning it
up and plan to post shortly.

-- 
Brian Beattie
IBM Linux Technology Center - MPIO/SAN
bbeattie@sequent.com
503.578.5899  Des2-3C-5
