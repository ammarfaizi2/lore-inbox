Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVJNSNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVJNSNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVJNSNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:13:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:48044 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750828AbVJNSNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:13:12 -0400
Date: Fri, 14 Oct 2005 11:12:37 -0700
From: Greg KH <greg@kroah.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, iss_storagedev@hp.com,
       Jakub Jelinek <jj@ultra.linux.cz>, Frodo Looijaard <frodol@dds.nl>,
       Jean Delvare <khali@linux-fr.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Roland Dreier <rolandd@cisco.com>,
       Sergio Rozanski Filho <aris@cathedrallabs.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pierre Ossman <drzeus-wbsd@drzeus.cx>,
       Carsten Gross <carsten@sol.wh-hms.uni-ulm.de>,
       David Hinds <dahinds@users.sourceforge.net>,
       Vinh Truong <vinh.truong@eng.sun.com>,
       Mark Douglas Corner <mcorner@umich.edu>,
       Michael Downey <downey@zymeta.com>, Antonino Daplas <adaplas@pol.net>,
       Ben Gardner <bgardner@wabtec.com>
Subject: Re: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
Message-ID: <20051014181237.GC17179@kroah.com>
References: <200510132128.45171.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510132128.45171.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 09:28:44PM +0200, Jesper Juhl wrote:
> --- linux-2.6.14-rc4-orig/drivers/usb/class/bluetty.c	2005-08-29 01:41:01.000000000 +0200

This driver is about to be deleted from the tree (2.6.15 will remove
it).  So I doubt you want to care about it.

> --- linux-2.6.14-rc4-orig/drivers/usb/input/keyspan_remote.c	2005-10-11 22:41:21.000000000 +0200
> +++ linux-2.6.14-rc4/drivers/usb/input/keyspan_remote.c	2005-10-12 16:29:31.000000000 +0200
> @@ -557,8 +557,7 @@ error:
>  	if (remote->in_buffer)
>  		usb_buffer_free(remote->udev, RECV_SIZE, remote->in_buffer, remote->in_dma);
>  
> -	if (remote)
> -		kfree(remote);
> +	kfree(remote);
>  
>  	return retval;
>  }

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
