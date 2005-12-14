Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVLNMBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVLNMBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 07:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVLNMBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 07:01:54 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6215
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932211AbVLNMBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 07:01:53 -0500
Date: Wed, 14 Dec 2005 13:01:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       Sridhar Samudrala <sri@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/6] Critical Page Pool
Message-ID: <20051214120152.GB5270@opteron.random>
References: <439FCECA.3060909@us.ibm.com> <20051214100841.GA18381@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214100841.GA18381@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 11:08:41AM +0100, Pavel Machek wrote:
> because reserved memory pool would have to be "sum of all network
> interface bandwidths * ammount of time expected to survive without
> network" which is way too much.

Yes, a global pool isn't really useful. A per-subsystem pool would be
more reasonable...

> gigabytes into your machine. But don't go introducing infrastructure
> that _can't_ be used right.

Agreed, the current design of the patch can't be used right.
