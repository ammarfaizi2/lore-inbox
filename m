Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWJ1VjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWJ1VjU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 17:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWJ1VjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 17:39:20 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57616 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964871AbWJ1VjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 17:39:19 -0400
Date: Sat, 28 Oct 2006 23:39:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Brownell <david-b@pacbell.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, toralf.foerster@gmx.de,
       netdev@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       link@miggy.org, greg@kroah.com, akpm@osdl.org, zippel@linux-m68k.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Message-ID: <20061028213918.GE27968@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061025165858.b76b4fd8.randy.dunlap@oracle.com> <20061028112122.GA14316@infradead.org> <200610281410.13679.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610281410.13679.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 02:10:09PM -0700, David Brownell wrote:
> On Saturday 28 October 2006 4:21 am, Christoph Hellwig wrote:
> 
> > This is really awkward and against what we do in any other driver.
> 
> Awkward, yes -- which is why I posted the non-awkward version,
> which is repeated below.  (No thanks to "diff" for making the
> patch ugly though; the resulting code is clean and non-awkward,
> moving that function helped.)
>...
> --- g26.orig/drivers/usb/net/usbnet.c	2006-10-24 18:29:28.000000000 -0700
> +++ g26/drivers/usb/net/usbnet.c	2006-10-25 19:07:16.000000000 -0700
> @@ -669,6 +669,9 @@ done:
>   * they'll probably want to use this base set.
>   */
>  
> +#if defined(CONFIG_MII) || defined(CONFIG_MII_MODULE)
> +#define HAVE_MII
>...

This seems to cause a CONFIG_USB_USBNET=y, CONFIG_MII=m breakage
(as already described earlier in this thread)?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

