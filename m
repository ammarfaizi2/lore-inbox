Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWAIOOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWAIOOR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWAIOOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:14:16 -0500
Received: from verein.lst.de ([213.95.11.210]:44772 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750860AbWAIOOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:14:16 -0500
Date: Mon, 9 Jan 2006 15:13:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: akpm@osdl.org, carlos@parisc-linux.org, willy@parisc-linux.org,
       linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] [PATCH 1/5] Add generic compat_siginfo_t
Message-ID: <20060109141355.GA22296@lst.de>
References: <20060108193755.GH3782@tachyon.int.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060108193755.GH3782@tachyon.int.mcmartin.ca>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-mm already has a much better implementation for compat_sys_timer_create
that doesn't require all the sigevent churn in this patch (which btw
doesn't seem to be mentioned in the changelog at all).  But even with
that remove there seems to be a lot of useless ifdef and indirection
in this patch.  Over the next days I'll send out my generic compat
singal bits which don't require all this, but otoh require every
architecture to supply helpers.  If you can make those generic without
all the ifdef an additional header bits all power to you!

