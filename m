Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750734AbWFEWaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWFEWaH (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 18:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWFEWaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 18:30:06 -0400
Received: from amdext3.amd.com ([139.95.251.6]:50097 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1750734AbWFEWaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 18:30:04 -0400
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Mon, 5 Jun 2006 16:29:08 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Pierre Ossman" <drzeus-list@drzeus.cx>
cc: linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk
Subject: Re: 2GB MMC/SD cards
Message-ID: <20060605222908.GC4996@cosmic.amd.com>
References: <4481FB80.40709@drzeus.cx>
MIME-Version: 1.0
In-Reply-To: <4481FB80.40709@drzeus.cx>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 05 Jun 2006 22:29:08.0157 (UTC)
 FILETIME=[75CD06D0:01C688EF]
X-WSS-ID: 689A6FB927G5908829-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/06 23:13 +0200, "Pierre Ossman" wrote:
> Matt Reimer wrote:
> 
> That's what I thought until I looked closer at the Sandisk specs. Until
> we can see what the official specs say, we won't really know what the
> correct behaviour is. The Nokia boys working on the 770 have a copy.
> Perhaps someone here knows how to get in touch with one of them that can
> have a look?

I'm not 100% sure what the community stance is on using the simplified specs.
I do believe the answer lies definitively within, but I'll refrain from
quoting it to avoid any legal complaints.  For the longest time, my gut
feeling has been that 512 byte writes were always accepted - but since all of
our 2G and 4G cards support WRITE_BL_PARTIAL, we haven't had a chance to 
prove the argument one way or the other.

We first heard about very large card issues from one of our customers, and
we haven't heard any more problems since we gave them a patch to force the
sector size on all SD/MMC cards to 512 bytes.  Thats just anecdotal evidence,
but it is food for thought.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

