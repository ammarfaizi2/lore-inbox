Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbUKALKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUKALKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 06:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbUKALKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 06:10:33 -0500
Received: from cantor.suse.de ([195.135.220.2]:23777 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261400AbUKALKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 06:10:30 -0500
Date: Mon, 1 Nov 2004 12:10:29 +0100
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, pluto@pld-linux.org
Subject: Re: unit-at-a-time...
Message-ID: <20041101111029.GB24175@wotan.suse.de>
References: <200411011102.iA1B2jbX012340@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411011102.iA1B2jbX012340@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It happened when I added perfctr to a 2.6.5-based SuSE kernel,
> and compiled the whole thing with gcc-3.4.0 (or 3.4.1, don't
> remember). Perfctr normally adds a little stack usage to the
> context-switch path, but gcc-3.4 made it much worse.
> Disabling unit-at-a-time solved the problem.

Better fix would have been a few strategic "noinline"s.
If you want noinline just say it explicitely.

Also I hope they were not all in the same callchain,
if yes you would have only hidden the problem.

-Andi
