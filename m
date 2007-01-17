Return-Path: <linux-kernel-owner+w=401wt.eu-S1751643AbXAQVRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbXAQVRe (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbXAQVRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:17:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:39727 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbXAQVRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:17:33 -0500
Date: Wed, 17 Jan 2007 13:14:47 -0800
From: Greg KH <greg@kroah.com>
To: Frank Haverkamp <haver@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix missing include of list.h in sysfs.h
Message-ID: <20070117211447.GA32495@kroah.com>
References: <1169052679.21717.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1169052679.21717.9.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 05:51:18PM +0100, Frank Haverkamp wrote:
> Sysfs.h uses definitions (e.g. struct list_head s_sibling) from list.h
> but does not include it.
> 
> Signed-off-by: Frank Haverkamp <haver@vnet.ibm.com>
> ---
>  include/linux/sysfs.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- ubi-2.6.git.orig/include/linux/sysfs.h
> +++ ubi-2.6.git/include/linux/sysfs.h
> @@ -11,6 +11,7 @@
>  #define _SYSFS_H_
>  
>  #include <linux/compiler.h>
> +#include <linux/list.h>
>  #include <asm/atomic.h>

Does this currently cause a build error on any platform for 2.6.20-rc5?

thanks,

greg k-h
