Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVKUW0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVKUW0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVKUW0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:26:48 -0500
Received: from [205.233.219.253] ([205.233.219.253]:13193 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1751149AbVKUW0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:26:47 -0500
Date: Mon, 21 Nov 2005 17:23:47 -0500
From: Jody McIntyre <scjody@steamballoon.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Adrian Bunk <bunk@stusta.de>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/csr1212.c: remove dead code
Message-ID: <20051121222347.GP20781@conscoop.ottawa.on.ca>
References: <20051120231000.GE16060@stusta.de> <438223D9.8010504@s5r6.in-berlin.de> <20051121214130.GL20781@conscoop.ottawa.on.ca> <438243E2.6050807@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438243E2.6050807@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 11:02:10PM +0100, Stefan Richter wrote:

> -		if (dentry->kv->key.id == CSR1212_KV_ID_EXTENDED_ROM) {
> -			csr1212_get_keyval(csr, dentry->kv);
> -
> +		if (dentry->kv->key.id == CSR1212_KV_ID_EXTENDED_ROM &&
> +		    !dentry->kv->valid) {
> +			ret = _csr1212_read_keyval(csr, dentry->kv);
>  			if (ret != CSR1212_SUCCESS)
>  				return ret;
>  		}

Duh :/

> Although I am not quite sure if the check for !valid is really required. 
> It certainly cannot hurt.

That's a separate issue so it should be a separate patch.  I'll do it
though.

Cheers,
Jody

> -- 
> Stefan Richter
> -=====-=-=-= =-== =-=-=
> http://arcgraph.de/sr/
