Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274426AbRJJDNb>; Tue, 9 Oct 2001 23:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274427AbRJJDNV>; Tue, 9 Oct 2001 23:13:21 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:44815 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274426AbRJJDNI>;
	Tue, 9 Oct 2001 23:13:08 -0400
Date: Tue, 9 Oct 2001 20:06:13 -0700
From: Greg KH <greg@kroah.com>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, alan <alan@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.4.10-ac10: more MODULE_LICENSE patches
Message-ID: <20011009200613.C4526@kroah.com>
In-Reply-To: <3BC3AC55.90606@si.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC3AC55.90606@si.rr.com>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 10:03:01PM -0400, Frank Davis wrote:
> --- drivers/usb/hub.c.old	Mon Oct  8 18:25:36 2001
> +++ drivers/usb/hub.c	Tue Oct  9 21:17:47 2001
> @@ -856,7 +856,7 @@
>  };
>  
>  MODULE_DEVICE_TABLE (usb, hub_id_table);
> -
> +MODULE_LICENSE("GPL");
>  static struct usb_driver hub_driver = {
>  	name:		"hub",
>  	probe:		hub_probe,

hub.c is not a module.  Alan, please do not apply.


> --- drivers/usb/inode.c.old	Mon Oct  8 18:25:37 2001
> +++ drivers/usb/inode.c	Tue Oct  9 21:15:15 2001
> @@ -767,4 +767,5 @@
>  #if 0
>  module_init(usbdevfs_init);
>  module_exit(usbdevfs_cleanup);
> +MODULE_LICENSE("GPL");
>  #endif

inode.c is not a module either.  Alan, please do not apply.

Both of these files are covered with the MODULE_LICENSE found in usb.c

thanks,

greg k-h
