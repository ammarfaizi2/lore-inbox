Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbVJ1IOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbVJ1IOE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 04:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbVJ1IOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 04:14:04 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:15805 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1751615AbVJ1IOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 04:14:01 -0400
Date: Fri, 28 Oct 2005 10:13:59 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: John Bowler <jbowler@acm.org>
Cc: "'Deepak Saxena'" <dsaxena@plexity.net>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [PATCH] 2.6.14-rc3 ixp4xx_copy_from little endian/alignment
Message-ID: <20051028081359.GA26901@xi.wantstofly.org>
References: <000e01c5db86$29ba4120$1001a8c0@kalmiopsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000e01c5db86$29ba4120$1001a8c0@kalmiopsis>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 11:09:31PM -0700, John Bowler wrote:

> +/* On a little-endian IXP4XX system (tested on NSLU2) contrary to the
> + * Intel documentation LDRH/STRH appears to XOR the address with 10b.

It's unlikely that ldrh/strh in LE mode behave differently than
on any other little-endian ARM system out there.  Maybe what was
meant is that this flaw only applies to accesses to the flash
controller (more likely)?  If so, can the comment be updated to
reflect that?


thanks,
Lennert
