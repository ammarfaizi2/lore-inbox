Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVDESgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVDESgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVDESdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:33:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:22958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261882AbVDESdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:33:07 -0400
Date: Tue, 5 Apr 2005 11:32:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: "Theodore Ts'o" <tytso@mit.edu>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, stable@kernel.org, netdev@oss.sgi.com
Subject: Re: [07/08] [TCP] Fix BIC congestion avoidance algorithm error
Message-ID: <20050405113241.3389c9b8@dxpl.pdx.osdl.net>
In-Reply-To: <20050405112608.0b3c07f0.davem@davemloft.net>
References: <20050405164539.GA17299@kroah.com>
	<20050405164758.GH17299@kroah.com>
	<20050405182202.GA11979@thunk.org>
	<20050405112608.0b3c07f0.davem@davemloft.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005 11:26:08 -0700
"David S. Miller" <davem@davemloft.net> wrote:

> On Tue, 5 Apr 2005 14:22:02 -0400
> Theodore Ts'o <tytso@mit.edu> wrote:
> 
> > If the congestion control alogirthm is "Reno-like", what is
> > user-visible impact to users?  There are OS's out there with TCP/IP
> > stacks that are still using Reno, aren't there?  
> 
> An incorrect implementation of any congestion control algorithm
> has ramifications not considered when the congestion control
> author verified the design of his algorithm.
> 
> This has a large impact on every user on the internet, not just
> Linux machines.
> 
> Perhaps on a microscopic scale "this" part of the BIC algorithm
> was just behaving Reno-like due to the bug, but what implications
> does that error have as applied to the other heuristics in BIC?
> This is what I'm talking about.  BIC operates in several modes,
> one of which is a pseudo binary search mode, and another is a
> less aggressive slower increase mode.

> Therefore I think fixes to congestion control algorithms which
> are enabled by default always should take a high priority in
> the stable kernels.

Also, hopefully distro vendors will pick up 2.6.11.X fixes and update their customers.

