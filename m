Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTLBXsy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbTLBXsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:48:53 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:32202 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264454AbTLBXsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:48:50 -0500
Date: Tue, 2 Dec 2003 18:31:25 -0500
From: Ben Collins <bcollins@debian.org>
To: Martin Waitz <tali@admingilde.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix use-after-free in sbp2.c
Message-ID: <20031202233125.GP19051@phunnypharm.org>
References: <20031201210212.GA2184@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201210212.GA2184@admingilde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 10:02:12PM +0100, Martin Waitz wrote:
> hi :)
> 
> when using some checking code (CONFIG_DEBUG_{SLAB,SPINLOCK_SLEEP},
> sbp2 fails to log in into my external hd enclosure.
> 
> that is because sbp2_agent_reset sends a packet and waits
> for its delivery.
> however, the function used to create the packet activates
> auto-destruct of the packet via hpsb_set_packet_complete_task.
> thus, the semaphore used for synchronization is destroyed
> while the sending task is waiting.
> 
> the following patch (against -test11) fixes sbp2 for me

Could you test what's in our repo first? We've already fixed this, but
it was done in a way different way than you did (we got rid of the
semaphore).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
