Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVAOWGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVAOWGt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 17:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVAOWFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 17:05:05 -0500
Received: from news.suse.de ([195.135.220.2]:60630 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262338AbVAOWBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 17:01:52 -0500
Date: Sat, 15 Jan 2005 23:01:51 +0100
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: slab.c use of __get_user and sparse
Message-ID: <20050115220151.GA16442@wotan.suse.de>
References: <20050115213906.GA22486@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115213906.GA22486@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Based on the comment it is understood that suddenly this pointer points
> to userspace, because the module got unloaded.
> I wonder why we can rely on the same address now the module got unloaded -
> we may risk this virtual address is taken over by someone else?

The address is not user space; you would be lying.

Perhaps it's best to get rid of the hack completely. Turn kmem_cache_t->name
into an array and copy the name instead of storing the pointer, then
it wouldn't be needed at all.

-Andi
