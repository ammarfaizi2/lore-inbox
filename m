Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263006AbTCYRK5>; Tue, 25 Mar 2003 12:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263056AbTCYRK5>; Tue, 25 Mar 2003 12:10:57 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:10765 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263006AbTCYRKz>; Tue, 25 Mar 2003 12:10:55 -0500
Date: Tue, 25 Mar 2003 17:22:03 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Petr Cisar <petr.cisar@gtsgroup.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange cursor behaviour in Radeon 8500 fb console in 2.5.66
In-Reply-To: <20030325163730.A11957@cuculus.switch.gts.cz>
Message-ID: <Pine.LNX.4.44.0303251720320.3789-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Since (I guess) 2.5.58, there have been problems with cursor in Radeon framebuffer console. In the previous versions the cursor was nat visible at all. Now (in 2.5.66) it blinks iregularily and at times it changes shape and color (it seems that something writes in the cursor's image).
> 
> Has anyone experienced the same and aren't there any patches ?

The problem is the the sync method used. In fb_get_buffer_offset the 
spinlock is causing syncing problems. Working on it.



