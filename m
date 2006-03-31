Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWCaBWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWCaBWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 20:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWCaBWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 20:22:41 -0500
Received: from colin.muc.de ([193.149.48.1]:7689 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750711AbWCaBWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 20:22:41 -0500
Date: 31 Mar 2006 03:22:35 +0200
Date: Fri, 31 Mar 2006 03:22:35 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: adrian@smop.co.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1 leaks in dvb playback (found)
Message-ID: <20060331012235.GB45568@muc.de>
References: <20060330004518.GA23404@smop.co.uk> <20060330225830.GA24009@smop.co.uk> <20060330231131.GA25029@smop.co.uk> <20060330.152821.24959319.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330.152821.24959319.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 03:28:21PM -0800, David S. Miller wrote:
> From: Adrian Bridgett <adrian@smop.co.uk>
> Date: Fri, 31 Mar 2006 00:11:31 +0100
> 
> > On Thu, Mar 30, 2006 at 23:58:30 +0100 (+0100), adrian wrote:
> > > What I thought was just one patch was actually two and it was the
> > > other patch causing the problem - "Do not lose accepted socket when
> > > -ENFILE/-EMFILE".
> > 
> > Hmm - it looks like it was meant to be reverted in 2.6.16-rc1-mm4,5 FWIW.
> 
> So is the current version in Linus's tree causing this problem?

I don't know if it's this patch, but I definitely see a socket
leak here with linus tree at least since -git8. It unfortunately takes a day 
or two to really trigger, so binary search would be difficult.

-Andi
