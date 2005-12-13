Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVLMOu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVLMOu5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbVLMOu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:50:56 -0500
Received: from cantor2.suse.de ([195.135.220.15]:44253 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964982AbVLMOu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:50:56 -0500
Date: Tue, 13 Dec 2005 15:50:54 +0100
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] skge: get rid of warning on race
Message-ID: <20051213145054.GA24897@suse.de>
References: <200512130559.jBD5xUjf015319@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200512130559.jBD5xUjf015319@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Dec 12, Linux Kernel Mailing List wrote:

> tree 987cfbd2134b82bea55c55fa17bd70d29df70458
> parent 0e670506668a43e1355b8f10c33d081a676bd521
> author Stephen Hemminger <shemminger@osdl.org> Wed, 07 Dec 2005 07:01:49 -0800
> committer Jeff Garzik <jgarzik@pobox.com> Tue, 13 Dec 2005 09:33:03 -0500
> 
> [PATCH] skge: get rid of warning on race

>  drivers/net/skge.c |   10 ++++++----

> -		netif_stop_queue(dev);
> -		spin_unlock_irqrestore(&skge->tx_lock, flags);
> +		if (!netif_stopped(dev)) {
> +			netif_stop_queue(dev);

Current Linus tree does not compile:

drivers/net/skge.c:2283: error: implicit declaration of function 'netif_stopped'


-- 
short story of a lazy sysadmin:
 alias appserv=wotan
