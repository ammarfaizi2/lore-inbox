Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbTDNAZX (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 20:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTDNAZX (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 20:25:23 -0400
Received: from golf.rb.xcalibre.co.uk ([217.8.240.16]:6662 "EHLO
	golf.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S262700AbTDNAZW (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 20:25:22 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair Strachan <alistair@devzero.co.uk>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.67-mm2
Date: Mon, 14 Apr 2003 01:36:21 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
References: <200304132059.11503.alistair@devzero.co.uk> <20030413130543.081c80fd.akpm@digeo.com>
In-Reply-To: <20030413130543.081c80fd.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304140136.21588.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 April 2003 21:05, Andrew Morton wrote:
>
> It's a bk bug.  This might make it boot:
>
>  drivers/base/class.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> diff -puN drivers/base/class.c~a drivers/base/class.c
> --- 25/drivers/base/class.c~a	2003-04-13 13:04:47.000000000 -0700
> +++ 25-akpm/drivers/base/class.c	2003-04-13 13:04:52.000000000 -0700
> @@ -105,7 +105,7 @@ int devclass_add_driver(struct device_dr
>  	struct device_class * cls = get_devclass(drv->devclass);
>  	int error = 0;
>
> -	if (cls) {
> +	if (cls && cls->subsys) {
>  		down_write(&cls->subsys.rwsem);
>  		pr_debug("device class %s: adding driver %s:%s\n",
>  			 cls->name,drv->bus->name,drv->name);
>

Ah yes. Works fine, thanks.

Cheers,
Alistair.

