Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273920AbRIRVAb>; Tue, 18 Sep 2001 17:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273914AbRIRVAM>; Tue, 18 Sep 2001 17:00:12 -0400
Received: from stine.vestdata.no ([195.204.68.10]:64723 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S272667AbRIRVAC>; Tue, 18 Sep 2001 17:00:02 -0400
Date: Tue, 18 Sep 2001 22:59:52 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Ingo Molnar <mingo@elte.hu>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] multipath RAID personality, 2.4.10-pre9
Message-ID: <20010918225952.D5590@vestdata.no>
In-Reply-To: <20010916150806.E1541@turbolinux.com> <Pine.LNX.4.33.0109170113010.3960-100000@localhost.localdomain> <20010918203946.A12814@wyvern>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010918203946.A12814@wyvern>; from adrian.bridgett@iname.com on Tue, Sep 18, 2001 at 08:39:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 08:39:46PM +0100, Adrian Bridgett wrote:
> Do you have plans to change this?  I know that the SDD software for AIX load
> balances between paths (and I think EMC's Powerpaths do for AIX too), DMP
> (from Veritas) for Solaris doesn't.
> 
> In fact that brings up another point - which path do you use by default?  If
> you have the SAN situation where you have a farm of servers each with two FC
> cards two two FC switches and then to two ports on a storage array, you
> don't want everything going to the first switch.  Just picking one path to
> use at random would be preferable (unless you want to swap every other
> servers cables around).

I think the multipath driver would benefit from something like the
different modes in the new network bonding driver:
* round robin
* active backup policy
* XOR

(Not sure if XOR would be needed for md?)

I think some other ideas can be stolen from the bonding driver as well,
as the problem is very simular - e.g. the concept of low level drivers
(optionally) delivering status information, so md don't have to try and
fail to detect a link is down, and the timeout settings.


-- 
Ragnar Kjørstad
Big Storage
