Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311688AbSCNR26>; Thu, 14 Mar 2002 12:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311689AbSCNR2i>; Thu, 14 Mar 2002 12:28:38 -0500
Received: from rj.sgi.com ([204.94.215.100]:39571 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S311688AbSCNR2h>;
	Thu, 14 Mar 2002 12:28:37 -0500
Date: Thu, 14 Mar 2002 09:28:08 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: Erich Focht <focht@ess.nec.de>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Node affine NUMA scheduler
Message-ID: <20020314172808.GB138234@sgi.com>
Mail-Followup-To: Erich Focht <focht@ess.nec.de>,
	lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020314025818.GA136486@sgi.com> <Pine.LNX.4.21.0203141459260.12844-100000@sx6.ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0203141459260.12844-100000@sx6.ess.nec.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 03:54:12PM +0100, Erich Focht wrote:
> Jesse,
> 
> thanks for running the tests. Actually "hackbench" is a bad example for
> the node affinity (though it's a good test for heavy scheduling). The code
> forks but doesn't exec and therefore all hackbench tasks have the same
> homenode. Also the tasks are not particularly memory bandwidth or latency
> hungry, therefore node affinity won't speed them up. I'm actually glad
> that they aren't slower, that shows that the additional overhead is small.

Alright, I'll try running some other numbers too, what can you
recommend other than aim and kernel compiles?

> Thanks for sending the macros for SGI_SN1/2, I'll include them. You
> probably use the DISCONTIGMEM patch, for that I append a small patch which
> "couples" DISCONTIGEMEM with the node affine scheduler such that pages
> will be allocated on the node current->node instead of the node on which
> the task is currently running. Hackbench might slow down a bit but
> AIM7 should improve.

Sounds good, I'll have to update those macros later too (Jack
reminded me that physical node numbers aren't always the same as
logical node numbers).

Jesse
