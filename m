Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVK0OP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVK0OP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 09:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVK0OP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 09:15:28 -0500
Received: from hera.kernel.org ([140.211.167.34]:9956 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751065AbVK0OP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 09:15:28 -0500
Date: Sun, 27 Nov 2005 06:35:15 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vasily Averin <vvs@sw.ru>
Cc: linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@sw.ru>,
       netdev@oss.sgi.com, Daniele Venzano <venza@brownhat.org>
Subject: Re: [PATCH 2.4] sis900: come alive after temporary memory shortage
Message-ID: <20051127083515.GA20701@logos.cnet>
References: <438829AF.8060101@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438829AF.8060101@sw.ru>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2005 at 12:23:59PM +0300, Vasily Averin wrote:
> Hello Marcelo,
> 
> I would like to inform you that unfortunately the committed patch is wrong
> http://www.kernel.org/git/?p=linux/kernel/git/marcelo/linux-2.4.git;a=commit;h=ecf3337f76eaa94c5a771308d184dc248b74b725
> 
> +	int rx_work_limit =
> +		(sis_priv->dirty_rx - sis_priv->cur_rx) % NUM_RX_DESC;
> 
> when dirty_rx = cur_rx it computes limit=0, but should be NUM_RX_DESC
> 
> Could you please drop the wrong patch and use a new one based on the version
> approved by Daniele Venzano and Jeff Garzik
> http://www.kernel.org/git/?p=linux/kernel/git/jgarzik/netdev-2.6.git;a=commitdiff_plain;h=7380a78a973a8109c13cb0e47617c456b6f6e1f5;hp=b2795f596932286ef12dc08857960d654f577405


Will do - thanks Vasily.
