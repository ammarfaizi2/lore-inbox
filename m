Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVBXEnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVBXEnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVBXEjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:39:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46475 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261821AbVBXEfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:35:50 -0500
Message-ID: <421D5997.5030002@pobox.com>
Date: Wed, 23 Feb 2005 23:35:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <hermes@gibson.dropbear.id.au>
CC: Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [7/14] Orinoco driver updates - use modern module_parm()
References: <20050224035355.GA32001@localhost.localdomain> <20050224035445.GB32001@localhost.localdomain> <20050224035524.GC32001@localhost.localdomain> <20050224035650.GD32001@localhost.localdomain> <20050224035718.GE32001@localhost.localdomain> <20050224035804.GF32001@localhost.localdomain> <20050224035957.GH32001@localhost.localdomain> <20050224040024.GI32001@localhost.localdomain>
In-Reply-To: <20050224040024.GI32001@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> Add descrptions to module parameters in the orinoco driver, and also
> add permissions to allow them to be exported in sysfs.
> 
> Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>
> 
> Index: working-2.6/drivers/net/wireless/orinoco.c
> ===================================================================
> --- working-2.6.orig/drivers/net/wireless/orinoco.c	2005-02-10 13:19:14.000000000 +1100
> +++ working-2.6/drivers/net/wireless/orinoco.c	2005-02-10 13:24:03.000000000 +1100
> @@ -461,12 +461,14 @@
>  /* Level of debugging. Used in the macros in orinoco.h */
>  #ifdef ORINOCO_DEBUG
>  int orinoco_debug = ORINOCO_DEBUG;
> -module_param(orinoco_debug, int, 0);
> +module_param(orinoco_debug, int, 0644);
> +MODULE_PARM_DESC(orinoco_debug, "Debug level");
>  EXPORT_SYMBOL(orinoco_debug);
>  #endif

eventually it would be nice to support netif_msg_*

	Jeff



