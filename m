Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267568AbTAXGjP>; Fri, 24 Jan 2003 01:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267569AbTAXGjP>; Fri, 24 Jan 2003 01:39:15 -0500
Received: from franka.aracnet.com ([216.99.193.44]:48276 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267568AbTAXGjO>; Fri, 24 Jan 2003 01:39:14 -0500
Date: Thu, 23 Jan 2003 22:48:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: GrandMasterLee <masterlee@digitalroadkill.net>
cc: Austin Gonyou <austin@coremetrics.com>, linux-kernel@vger.kernel.org
Subject: Re: Using O(1) scheduler with 600 processes.
Message-ID: <438270000.1043390898@titus>
In-Reply-To: <1043389673.14486.7.camel@localhost>
References: <1043367029.28748.130.camel@UberGeek> <310350000.1043367864@titus> <1043388556.12894.23.camel@localhost> <435060000.1043389112@titus> <1043389673.14486.7.camel@localhost>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Heh..Well, I am currently using 2.4.19rc5aa1. We're having some major
> stack problems, so I first when through trying to update the XFS
> codebase in 2.4.19rc5aa1. That didn't prove very fruitful. I couldn't
> even fully reverse the patch for some reason.
> 
> So I decided to try 2.4.20aa1 instead, reversing the xfs patches, and
> then updating with a newer code base, worse problems reversing those xfs
> patches. 
> 
> SO I decided to just roll my own with the known features we use in
> production.
> 
> 2.4.20 + xfs + lvm106 + rmap or aavm + O(1) sched + pte-highmem. 

If you have enough ptes to want pte-highmem, I doubt you want rmap.
pte-chain space consumption will kill you. The calculations are pretty
easy to work out as to what the right solution is for your setup.

M.
