Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937179AbWLDVQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937179AbWLDVQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937392AbWLDVQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:16:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:50684 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937179AbWLDVQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:16:50 -0500
Subject: Re: [PATCH] Add Broadcom PHY support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Amy Fong <amy.fong@windriver.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jeff@garzik.org
In-Reply-To: <20060915201538.GA28483@lucciola.windriver.com>
References: <20060915201538.GA28483@lucciola.windriver.com>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 08:16:39 +1100
Message-Id: <1165266999.29784.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 16:15 -0400, Amy Fong wrote:
> [PATCH] Add Broadcom PHY support
> 
> This patch adds a driver to support the bcm5421s and bcm5461s PHY
> 
> Kernel version:  linux-2.6.18-rc6
> 
> Signed-off-by: Amy Fong 

Some 5421's need special initialisation (see drivers/net/sungem_phy.c),
might be worth having them there too. I was also wondering... for
spidernet, we need to enable the fiber mode on the PHY. Does phylib has
an API for that ?

I'd like to look into moving sungem and spidernet over to phylib.

Ben.


