Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVIFRdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVIFRdm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 13:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVIFRdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 13:33:42 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:42966 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750732AbVIFRdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 13:33:41 -0400
Date: Tue, 6 Sep 2005 10:33:32 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Use proper casting with signed timespec.tv_nsec
 values
In-Reply-To: <1125608627.22448.4.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.62.0509061032010.16745@schroedinger.engr.sgi.com>
References: <1125608627.22448.4.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2005, john stultz wrote:

> 	I recently ran into a bug with an older kernel where xtime's tv_nsec
> field had accumulated more then 2 seconds worth of time. The timespec's
> tv_nsec is a signed long, however gettimeofday() treats it as an
> unsigned long. Thus when the failure occured, very strange and difficult
> to debug time problems occurred.

How can that happen? I think the source of the problem needs to be fixed. 
The fix is only going decrease the likelyhood of the problem occurring.

We may need special measures if the system was frozen for some 
reason for longer than a certain time period.

