Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTFPDJr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 23:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTFPDJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 23:09:47 -0400
Received: from [66.212.224.118] ([66.212.224.118]:29188 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S263271AbTFPDJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 23:09:46 -0400
Date: Sun, 15 Jun 2003 23:12:19 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jeff <jeffpc@optonline.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit fields in struct net_device_stats
In-Reply-To: <200306152253.36768.jeffpc@optonline.net>
Message-ID: <Pine.LNX.4.50.0306152309220.32020-100000@montezuma.mastecende.com>
References: <200306152131.09983.jeffpc@optonline.net> <200306152253.36768.jeffpc@optonline.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jun 2003, Jeff wrote:

> I now realize, that locking is out of the question. Also, it has been

Well spinlocks in particular would be particularly ugly here and cause 
horrid cache line ping pong. Other methods of synchronization would have 
to be looked at.

> suggested to use per cpu stats and overflow into a global counter. (Thanks
> Zwane) This might be a better idea - the problem is, the counter won't be
> 100% accurate at all times. The degree of inaccuracy will vary with the
> threshold value. On the other hand, if the threshold is relatively low, no
> one will notice the difference these days.

This would be one method of doing updates and for stats it would be fine, 
however feel free to look into other ways...

	Zwane
-- 
function.linuxpower.ca
