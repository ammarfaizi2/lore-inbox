Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVJ3Wfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVJ3Wfp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 17:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVJ3Wfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 17:35:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932372AbVJ3Wfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 17:35:44 -0500
Date: Sun, 30 Oct 2005 14:35:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Deepak Saxena <dsaxena@plexity.net>
cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tony@atomide.com,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 0/5] HW RNG cleanup & new drivers
In-Reply-To: <20051030200219.GB4794@plexity.net>
Message-ID: <Pine.LNX.4.64.0510301433070.27915@g5.osdl.org>
References: <20051029191229.562454000@omelas> <4363F31F.2040303@pobox.com>
 <20051030200219.GB4794@plexity.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 Oct 2005, Deepak Saxena wrote:
> 
> I think moving it to user space will add more complexity for
> the case where the HW unit is shared with an in in-kernel driver.

Moving it to user space is just generally stupid.

Often, the random stuff comes from chipsets, not the CPU itself. Not 
user-accessible at all, and even if it were, it would be a bad idea to 
have user space do things the kernel does normally ("what northbridge do I 
have").

There may be use for a user-level library that handles the native CPU 
instructions for high performance, but that in no way negates the reason 
why /dev/random and friends exist in the first place.

		Linus
