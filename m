Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWGLPuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWGLPuh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWGLPuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:50:37 -0400
Received: from xenotime.net ([66.160.160.81]:37766 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751420AbWGLPuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:50:37 -0400
Date: Wed, 12 Jul 2006 08:53:19 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] add function documentation for register_chrdev()
Message-Id: <20060712085319.0ae7b346.rdunlap@xenotime.net>
In-Reply-To: <200607120946.16501@bilbo.math.uni-mannheim.de>
References: <200607120942.23071@bilbo.math.uni-mannheim.de>
	<200607120946.16501@bilbo.math.uni-mannheim.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 09:46:16 +0200 Rolf Eike Beer wrote:

> Documentation for register_chrdev() was missing completely.

I noticed that too.

Would you modify the patch to use the kernel-doc format, please?

See Documentation/kernel-doc-nano-HOWTO.txt or other source
files for examples.

and "-ve" is overused/overrated. :)  Please use "negative".
(even though Andrew just used -ve yesterday)


> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
> 
> ---
>  fs/char_dev.c |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index a4cbc67..ac28eaa 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -182,6 +182,29 @@ int alloc_chrdev_region(dev_t *dev, unsi
>  	return 0;
>  }
>  
> +/*
> + * Register a major number for character devices.
> + *
> + * major: major device number or 0 for dynamic allocation
> + * name: name of this range of devices
> + * fops: file operations associated with this devices
> + *
> + * If major == 0 this functions will dynamically allocate a major and return
> + * its number.
> + *
> + * If major > 0 this function will attempt to reserve a device with the given
> + * major number and will return zero on success.
> + *
> + * Returns a -ve errno on failure.
> + *
> + * The name of this device has nothing to do with the name of the device in
> + * /dev. It only helps to keep track of the different owners of devices. If
> + * your module name has only one type of devices it's ok to use e.g. the name
> + * of the module here.
> + *
> + * This function registers a range of 256 minor numbers. The first minor number
> + * is 0.
> + */
>  int register_chrdev(unsigned int major, const char *name,
>  		    const struct file_operations *fops)
>  {


---
~Randy
