Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267340AbTBNTvj>; Fri, 14 Feb 2003 14:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267367AbTBNTvj>; Fri, 14 Feb 2003 14:51:39 -0500
Received: from franka.aracnet.com ([216.99.193.44]:59625 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267340AbTBNTvg>; Fri, 14 Feb 2003 14:51:36 -0500
Date: Fri, 14 Feb 2003 12:01:11 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Andrew Theurer <habanero@us.ibm.com>,
       Mark Peloquin <peloquin@austin.ibm.com>
Subject: Re: [PATCH] percpu load avererages / *real* load averages
Message-ID: <74930000.1045252870@[10.10.2.4]>
In-Reply-To: <72980000.1045252305@[10.10.2.4]>
References: <72980000.1045252305@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Probably needs some tidying up before it's mergeable, but I like it. 
> Is useful as is, so I thought other people might want to look at it and
> give me feedback. Based very loosely on a earlier patch by Andrew Theurer
> that gave nr_running per cpu, but I wanted to see load averages. This is
> extremely useful for looking at scheduler rebalancing problems.
> 
> I think we should be basing the scheduler rebalance calculations off load
> averages, rather than a couple of sample points - I'll create a patch to
> do this sometime soon.

Oh, by tidying up, I mean this should probably be done in the per-cpu
areas, from the scheduler tick, lockless, and we shouldn't bother keeping
the global one - just derive it at read time. That'd make it might lighter
weight, but I just wanted a quick hack to see what was going on ;-)

M.

