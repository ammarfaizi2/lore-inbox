Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVKTXjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVKTXjd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVKTXjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:39:33 -0500
Received: from [205.233.219.253] ([205.233.219.253]:41679 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S932128AbVKTXjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:39:32 -0500
Date: Sun, 20 Nov 2005 18:33:51 -0500
From: Jody McIntyre <scjody@steamballoon.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: bcollins@debian.org, dan@dennedy.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/raw1394.c: fix a NULL pointer dereference
Message-ID: <20051120233351.GA20781@conscoop.ottawa.on.ca>
References: <20051120232009.GH16060@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120232009.GH16060@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 12:20:09AM +0100, Adrian Bunk wrote:
> +	if(cache->filled_head)
> +		kfree(cache->filled_head);

Try again.  kfree() of a NULL pointer is perfectly fine.

Jody
