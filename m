Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264871AbUE0QKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264871AbUE0QKS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 12:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264872AbUE0QKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 12:10:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53189 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264871AbUE0QKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 12:10:03 -0400
Message-ID: <40B612C7.8020502@pobox.com>
Date: Thu, 27 May 2004 12:09:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Zhu, Yi" <yi.zhu@intel.com>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Auzanneau Gregory <mls@reolight.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: idebus setup problem (2.6.7-rc1)
References: <3ACA40606221794F80A5670F0AF15F842DB1E0@PDSMSX403.ccr.corp.intel.com>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F842DB1E0@PDSMSX403.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhu, Yi wrote:
> --- linux-2.6.7-rc1-mm1.orig/drivers/ide/ide.c      2004-05-27
> 23:07:59.405138992 +0800
> +++ linux-2.6.7-rc1-mm1/drivers/ide/ide.c   2004-05-27
> 23:09:47.529701560 +0800
> @@ -2459,7 +2459,8 @@ void cleanup_module (void)
> 
>  #else /* !MODULE */
> 
> -__setup("", ide_setup);
> +__setup("hd", ide_setup);
> +__setup("ide", ide_setup);
> 
>  module_init(ide_init);


module_param() works for both the built-in case (where __setup is used), 
and also the modular case.  If this is getting changed, might as well do 
the right change...

	Jeff


