Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbUKQRmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbUKQRmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbUKQRmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:42:08 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:37844 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262443AbUKQRkS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:40:18 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 17 Nov 2004 18:25:19 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: jelle@foks.8m.com, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] cx88: fix printk arg. type
Message-ID: <20041117172519.GB8176@bytesex>
References: <419A89A3.90903@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419A89A3.90903@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -		dprintk(0, "ERROR: Firmware size mismatch (have %ld, expected %d)\n",
> +		dprintk(0, "ERROR: Firmware size mismatch (have %Zd, expected %d)\n",

Thanks, merged to cvs.  I like that 'Z'.  Or is that just a linux-kernel
printk specific thingy?  Or is this standardized somewhere?  So I could
use that in userspace code as well maybe?

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
