Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTEaX3z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 19:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTEaX3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 19:29:55 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:11745 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264495AbTEaX3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 19:29:53 -0400
Message-ID: <3ED93DB1.1080301@pacbell.net>
Date: Sat, 31 May 2003 16:41:37 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Andrew Morton <akpm@digeo.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch] 2.5.70-mm3: usb_gadget_* several times defined
References: <20030531013716.07d90773.akpm@digeo.com> <20030531210752.GK29425@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> 
> The following patch fixes it (drivers/usb/Makefile now includes gadget/
> entries):


No, the better fix is to revert whatever change added
USB_GADGET into drivers/usb/Makefile ... the slave/gadget
side API needs to be independent of the master/host side
code.



> --- linux-2.5.70-mm3/drivers/Makefile.old	2003-05-31 23:00:25.000000000 +0200
> +++ linux-2.5.70-mm3/drivers/Makefile	2003-05-31 23:00:44.000000000 +0200
> @@ -37,7 +37,6 @@
>  obj-$(CONFIG_PARIDE) 		+= block/paride/
>  obj-$(CONFIG_TC)		+= tc/
>  obj-$(CONFIG_USB)		+= usb/
> -obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
>  obj-$(CONFIG_INPUT)		+= input/
>  obj-$(CONFIG_GAMEPORT)		+= input/gameport/
>  obj-$(CONFIG_SERIO)		+= input/serio/
> 
> 
> 
> cu
> Adrian
> 



