Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbSLBFZF>; Mon, 2 Dec 2002 00:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSLBFYs>; Mon, 2 Dec 2002 00:24:48 -0500
Received: from dp.samba.org ([66.70.73.150]:3741 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264931AbSLBFYi>;
	Mon, 2 Dec 2002 00:24:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bob Miller <rem@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL PATCH 2.5.47] Remove compile warning from scsi/scsi.c 
In-reply-to: Your message of "Wed, 13 Nov 2002 14:27:10 -0800."
             <20021113222709.GB3336@doc.pdx.osdl.net> 
Date: Mon, 02 Dec 2002 14:57:00 +1100
Message-Id: <20021202053207.13A8D2C365@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021113222709.GB3336@doc.pdx.osdl.net> you write:
> diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> --- a/drivers/scsi/scsi.c	Wed Nov 13 14:09:57 2002
> +++ b/drivers/scsi/scsi.c	Wed Nov 13 14:09:57 2002
> @@ -1985,7 +1985,7 @@
>  	up_read(&scsi_devicelist_mutex);
>  	return 0;
>  
> -fail:
> +/* XXX fail: */
>  	printk(KERN_ERR "%s: Allocation failure during SCSI scanning, "
>  			"some SCSI devices might not be configured\n",
>  			__FUNCTION__);

That code is now unreachable, which can't be right.

(Catching up on trivial),
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
