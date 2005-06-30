Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVF3Rlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVF3Rlx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 13:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVF3Rlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 13:41:52 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38620 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262667AbVF3Rlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 13:41:51 -0400
Date: Thu, 30 Jun 2005 10:41:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org,
       paulus@samba.org, linuxppc-dev@ozlabs.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] ppc misusing NTP's time_offset value
Message-ID: <20050630174144.GG13179@smtp.west.cox.net>
References: <1120082751.24889.120.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120082751.24889.120.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 03:05:51PM -0700, john stultz wrote:
> Hey everyone,
> 
> 	As part of my timeofday rework, I've been looking at the NTP code and I
> noticed that the PPC architecture is apparently misusing the NTP's
> time_offset (it is a terrible name!) value as some form of timezone
> offset. This could cause problems when time_offset changed by the NTP
> code.
> 	
> 	This patch changes the PPC code so it uses a more clear local variable:
> timezone_offset.
> 
> Could a PPC maintainer verify this is correct?

As mentioned by Mikael, it's odd that this problem came up, since i
guess the wrong patch made it in.  Andrew, please grab this if you
haven't already.  Thanks.

Acked-by: Tom Rini <trini@kernel.crashing.org>

-- 
Tom Rini
http://gate.crashing.org/~trini/
