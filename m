Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWDZCRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWDZCRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 22:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWDZCRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 22:17:21 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:11917 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932345AbWDZCRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 22:17:20 -0400
Date: Wed, 26 Apr 2006 10:17:19 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [patch 1/2] kref: detect kref_put() with unreferenced object
Message-ID: <20060426021719.GA5619@miraclelinux.com>
References: <20060425082137.028875000@localhost.localdomain> <20060425082359.767915000@localhost.localdomain> <20060426002628.GB24343@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426002628.GB24343@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I really don't see how this is going to make it easier to debug
> anything.  Remember, when a kref goes to 0, it is automatically freed.
> So any code that tries to use it afterward just dies a horrible death,
> if CONFIG_DEBUG_SLAB is enabled.

Thanks, I finally understood it is not needed as you said.
So I can just remove that BUG_ON()es for detecting zero atomic_t counter
while I replace atomic_t counters with kref.
