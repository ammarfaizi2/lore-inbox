Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264784AbTIJI3L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbTIJI3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:29:11 -0400
Received: from ns.suse.de ([195.135.220.2]:14047 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264784AbTIJI3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:29:09 -0400
Date: Wed, 10 Sep 2003 10:29:08 +0200
From: Andi Kleen <ak@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/3] netpoll: netconsole
Message-ID: <20030910082908.GE29485@wotan.suse.de>
References: <20030910074256.GD4489@waste.org.suse.lists.linux.kernel> <p73znhdhxkx.fsf@oldwotan.suse.de> <20030910082435.GG4489@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910082435.GG4489@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, haven't encountered it. Which lock are we talking about, specifically?

The hardware register lock of the low level device drivers.

It's a different lock for each driver.

They take it usually in all functions that access hardware registers,
including poll.

> It ups the interface if necessary and has enough info to build a
> complete raw packet so if I understand you correctly, it's already
> there. I start getting netconsole messages immediately after
> driver/net initcalls.

Ok, great.

-Andi
