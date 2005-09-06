Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVIFCPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVIFCPg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 22:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVIFCPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 22:15:36 -0400
Received: from gate.ebshome.net ([64.81.67.12]:16307 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S1751255AbVIFCPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 22:15:36 -0400
Date: Mon, 5 Sep 2005 19:15:35 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: viro@ZenIV.linux.org.uk
Cc: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missed s/u32/pm_message_t/ in arch/ppc/syslib/ocp.c
Message-ID: <20050906021535.GA5512@gate.ebshome.net>
Mail-Followup-To: viro@ZenIV.linux.org.uk,
	Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20050906004423.GO5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906004423.GO5155@ZenIV.linux.org.uk>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 01:44:23AM +0100, viro@ZenIV.linux.org.uk wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ----
> diff -urN RC13-git5-mga/arch/ppc/syslib/ocp.c RC13-git5-ppc44x-pm/arch/ppc/syslib/ocp.c
> --- RC13-git5-mga/arch/ppc/syslib/ocp.c	2005-08-28 23:09:40.000000000 -0400
> +++ RC13-git5-ppc44x-pm/arch/ppc/syslib/ocp.c	2005-09-05 16:41:17.000000000 -0400
> @@ -165,7 +165,7 @@
>  }
>  
>  static int
> -ocp_device_suspend(struct device *dev, u32 state)
> +ocp_device_suspend(struct device *dev, pm_message_t state)
>  {
>  	struct ocp_device *ocp_dev = to_ocp_dev(dev);
>  	struct ocp_driver *ocp_drv = to_ocp_drv(dev->driver);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

Identical fix is already in -mm
