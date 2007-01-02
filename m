Return-Path: <linux-kernel-owner+w=401wt.eu-S1754372AbXABCG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbXABCG3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 21:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754767AbXABCG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 21:06:29 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:39798 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbXABCG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 21:06:28 -0500
X-Greylist: delayed 937 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jan 2007 21:06:27 EST
Message-ID: <4599BAE1.9050804@student.ltu.se>
Date: Tue, 02 Jan 2007 02:52:33 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/8] UML - audio driver formatting
References: <200701011947.l01JlAMo020761@ccure.user-mode-linux.org>
In-Reply-To: <200701011947.l01JlAMo020761@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> Whitespace and style fixes.
>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> --
>  arch/um/drivers/hostaudio_kern.c |  160 +++++++++++++++++----------------------
>  1 file changed, 73 insertions(+), 87 deletions(-)
>
> Index: linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c
> ===================================================================
> --- linux-2.6.18-mm.orig/arch/um/drivers/hostaudio_kern.c	2006-12-29 21:13:41.000000000 -0500
> +++ linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c	2006-12-29 21:13:42.000000000 -0500
> @@ -15,11 +15,11 @@
>  #include "os.h"
>  
>  struct hostaudio_state {
> -  int fd;
> +	int fd;
>  };
>  
>  struct hostmixer_state {
> -  int fd;
> +	int fd;
>  };
>  
>  #define HOSTAUDIO_DEV_DSP "/dev/sound/dsp"
> @@ -72,12 +72,12 @@ MODULE_PARM_DESC(mixer, MIXER_HELP);
>  static ssize_t hostaudio_read(struct file *file, char __user *buffer,
>  			      size_t count, loff_t *ppos)
>  {
> -        struct hostaudio_state *state = file->private_data;
> +	struct hostaudio_state *state = file->private_data;
>  	void *kbuf;
>  	int err;
>  
>  #ifdef DEBUG
> -        printk("hostaudio: read called, count = %d\n", count);
> +	printk("hostaudio: read called, count = %d\n", count);
>  #endif
>  
>  	kbuf = kmalloc(count, GFP_KERNEL);
> @@ -91,7 +91,7 @@ static ssize_t hostaudio_read(struct fil
>  	if(copy_to_user(buffer, kbuf, err))
>  		err = -EFAULT;
>  
> - out:
> +out:
>   
Isn't labels _suppose_ to be spaced? (due to "grep", if I'm not mistaken)...
>  	kfree(kbuf);
>  	return(err);
>  }
> @@ -99,12 +99,12 @@ static ssize_t hostaudio_read(struct fil
<snip>

Richard Knutsson

