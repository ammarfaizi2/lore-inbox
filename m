Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVDOEBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVDOEBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 00:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVDOEBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 00:01:15 -0400
Received: from gate.ebshome.net ([64.81.67.12]:24193 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S261731AbVDOEBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 00:01:13 -0400
Date: Thu, 14 Apr 2005 21:01:12 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org
Subject: Re: {PATCH] Fix IBM EMAC driver ioctl bug
Message-ID: <20050415040112.GB11362@gate.ebshome.net>
Mail-Followup-To: Geoff Levand <geoffrey.levand@am.sony.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
References: <425EB470.9040203@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425EB470.9040203@am.sony.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 11:20:32AM -0700, Geoff Levand wrote:
> Fix IBM EMAC driver ioctl bug.
> 
> I found IBM EMAC driver bug.
> So mii-tool command print wrong status.
> 
>   # mii-tool
>   eth0: 10 Mbit, half duplex, no link
>   eth1: 10 Mbit, half duplex, no link
> 
> I can get correct status on fixed kernel.
> 
>   # mii-tool
>   eth0: negotiated 100baseTx-FD, link okZZ
>   eth1: negotiated 100baseTx-FD, link ok
> 

There is a problem with this patch. I'm aware of this problem for 
quite some time, but chose to keep the current code.

This IOCTL implementation has been here for many years in all 
revisions of the driver, so I think we should keep it as is, because 
some software could rely on it, and your change will break it. 

And all new code should use ethtool anyway :).

-- 
Eugene


