Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269509AbTHCTWk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 15:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269578AbTHCTWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 15:22:40 -0400
Received: from [66.212.224.118] ([66.212.224.118]:24583 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S269509AbTHCTWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 15:22:39 -0400
Date: Sun, 3 Aug 2003 15:10:56 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Abraham van der Merwe <abz@frogfoot.net>
Cc: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Subject: Re: sleeping in dev->tx_timeout?
In-Reply-To: <20030803183707.GA13728@oasis.frogfoot.net>
Message-ID: <Pine.LNX.4.53.0308031505390.3473@montezuma.mastecende.com>
References: <20030803183707.GA13728@oasis.frogfoot.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Aug 2003, Abraham van der Merwe wrote:

> Hi!
> 
> Is it safe to sleep in tx_timeout (in the networking code), i.e. to call
> schedule_timeout and friends from that routine?

No it's called from softirq context and with the dev->xmit_lock held in 
places.

-- 
function.linuxpower.ca
