Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271226AbTG2CWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271227AbTG2CWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:22:53 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:64647 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S271226AbTG2CWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:22:51 -0400
Message-ID: <3F25DE61.6030506@genebrew.com>
Date: Mon, 28 Jul 2003 22:39:29 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: davem@redhat.com, arjanv@redhat.com, torvalds@transmeta.com,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove module reference counting.
References: <20030729020058.592C02C296@lists.samba.org>
In-Reply-To: <20030729020058.592C02C296@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty,

> Yes, but that cuts both ways: noone fixes these broken drivers, but
> work around them using module removal, leaving newbies with broken
> laptops 8(

Good point; so there's the work of fixing power management with drivers 
known to load and unload correctly (dependent on hardware specs, 
undocumented registers, etcc), or adding refcounting to fix the 
remaining cases of drivers that do not unload safely (solvable in 
kernel). Pick your poison. :)

By the way, what about a reload option that re-inits the module? Is that 
possible/present, or subject to the same difficulties as unloading?

> Not really.  Adding modules is required.  Removing them is a more
> dubious goal, and if we didn't already have it, I know we'd balk at
> doing it.

Fair enough. I think we all agree that module unloading is a hard problem.

Thanks,
Rahul
-- 
Rahul Karnik
rahul@genebrew.com

