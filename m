Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVLNNEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVLNNEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVLNNEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:04:21 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:56777 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932068AbVLNNEV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:04:21 -0500
Subject: Re: [RFC][PATCH 0/6] Critical Page Pool
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Matthew Dobson <colpatch@us.ibm.com>,
       linux-kernel@vger.kernel.org, Sridhar Samudrala <sri@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <20051214120152.GB5270@opteron.random>
References: <439FCECA.3060909@us.ibm.com>
	 <20051214100841.GA18381@elf.ucw.cz>  <20051214120152.GB5270@opteron.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 13:03:56 +0000
Message-Id: <1134565436.25663.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-12-14 at 13:01 +0100, Andrea Arcangeli wrote:
> On Wed, Dec 14, 2005 at 11:08:41AM +0100, Pavel Machek wrote:
> > because reserved memory pool would have to be "sum of all network
> > interface bandwidths * ammount of time expected to survive without
> > network" which is way too much.
> 
> Yes, a global pool isn't really useful. A per-subsystem pool would be
> more reasonable...


The whole extra critical level seems dubious in itself. In 2.0/2.2 days
there were a set of patches that just dropped incoming memory on sockets
when the memory was tight unless they were marked as critical (ie NFS
swap). It worked rather well. The rest of the changes beyond that seem
excessive.

