Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267547AbTBJBiV>; Sun, 9 Feb 2003 20:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267515AbTBJBhL>; Sun, 9 Feb 2003 20:37:11 -0500
Received: from dp.samba.org ([66.70.73.150]:59309 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267529AbTBJBg5>;
	Sun, 9 Feb 2003 20:36:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Frank Davis <fdavis@si.rr.com>
Cc: Vineet M Abraham <vmabraham@hotmail.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] 2.5.59 : drivers/net/fc/iph5526.c 
In-reply-to: Your message of "Fri, 07 Feb 2003 12:23:22 CDT."
             <Pine.LNX.4.44.0302071221490.6917-100000@master> 
Date: Mon, 10 Feb 2003 11:34:02 +1100
Message-Id: <20030210014642.859B12C2C9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302071221490.6917-100000@master> you write:
> --- linux/drivers/net/fc/iph5526.c.old	2003-01-16 21:21:45.000000000 -
0500
> +++ linux/drivers/net/fc/iph5526.c	2003-02-07 02:13:43.000000000 -0500
> @@ -3769,7 +3769,7 @@
>  	for (i = 0; i <= MAX_FC_CARDS; i++) 
>  		fc[i] = NULL;
>  
> -	for (i = 0; i < clone_list[i].vendor_id != 0; i++)
> +	for (i = 0; ((i < clone_list[i].vendor_id) && (clone_list[i].vendor_id != 0)); i++)
>  	while ((pdev = pci_find_device(clone_list[i].vendor_id, clone_list[i].device_id, pdev))) {
>  		unsigned short pci_command;
>  		if (pci_enable_device(pdev))
> 

Once again, up to the author.  Vineet?

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
