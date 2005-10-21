Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVJUOAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVJUOAB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVJUOAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:00:01 -0400
Received: from www.swissdisk.com ([216.144.233.50]:62106 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S964950AbVJUOAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:00:01 -0400
Date: Fri, 21 Oct 2005 05:52:27 -0700
From: Ben Collins <bcollins@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sebastien.bouchard@ca.kontron.com, mark.gross@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cleanup printk and a 32/64bitism
Message-ID: <20051021125227.GC21649@swissdisk.com>
References: <1129901178.26367.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129901178.26367.37.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	ret = misc_register(&tlclk_miscdev);
>  	if (ret < 0) {
> -		printk(KERN_ERR " misc_register retruns %d\n", ret);
> +		printk(KERN_ERR "tlclk: misc_register returns %d.\n", ret);
>  		ret = -EBUSY;
>  		goto out3;
>  	}

Since you're getting nitpicky with this patch, then hopefully this
correction is ok :)

	printk(KERN_ERR "tlclk: misc_register returned %d.\n", ret);
						    ^^

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/
