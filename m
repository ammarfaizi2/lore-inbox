Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVGZXVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVGZXVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVGZXVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:21:02 -0400
Received: from waste.org ([216.27.176.166]:38096 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262339AbVGZXUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:20:54 -0400
Date: Tue, 26 Jul 2005 16:20:43 -0700
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: bunk@stusta.de, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] NETCONSOLE must depend on INET
Message-ID: <20050726232043.GB7425@waste.org>
References: <20050719182919.GA5531@stusta.de> <20050719.140104.68160812.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719.140104.68160812.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 02:01:04PM -0700, David S. Miller wrote:
> From: Adrian Bunk <bunk@stusta.de>
> Date: Tue, 19 Jul 2005 20:29:19 +0200
> 
> > NETCONSOLE=y and INET=n results in the following compile error:
> 
> Also applied, thanks Adrian.

I should have been cc:ed on this.

This problem also exists in PKTGEN. And this fix is incorrect as
neither is dependent on the IP part of the networking stack in any
substantive way. The right fix is to make inet_aton available outside
of CONFIG_INET (preferred) or making private copies of inet_aton.

-- 
Mathematics is the supreme nostalgia of our time.
