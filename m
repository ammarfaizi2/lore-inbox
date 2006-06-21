Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWFUWyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWFUWyl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWFUWyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:54:41 -0400
Received: from mail.suse.de ([195.135.220.2]:42700 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751513AbWFUWyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:54:40 -0400
Date: Wed, 21 Jun 2006 15:51:34 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Message-ID: <20060621225134.GA13618@kroah.com>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606211519550.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606211519550.5498@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 03:22:19PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 21 Jun 2006, Greg KH wrote:
> >
> >  123 files changed, 4169 insertions(+), 2440 deletions(-)
> 
> Btw, I get
> 
>   119 files changed, 3888 insertions(+), 2159 deletions(-)
> 
> Why? Becuause my default pull script has rename detection enabled, and I 
> get:
> 
>  rename include/linux/{usb_cdc.h => usb/cdc.h} (100%)
>  rename include/linux/{usb_input.h => usb/input.h} (100%)
>  rename include/linux/{usb_isp116x.h => usb/isp116x.h} (100%)
>  rename include/linux/{usb_sl811.h => usb/sl811.h} (71%)
> 
> which explains the off-by-four number (and the smaller number of 
> lines changed).
> 
> Just out of interest, could you enable that in your scripts too, so that 
> renames don't show up as huge deletes/creates (well, in this case, thet 
> were pretty small files, but you get the idea)?

Ok, but how?  I'm generating the diffstat in my script with:

	git diff origin..HEAD | diffstat -p1 >> $TMP_FILE

Is there a better way to see these renames?  In playing around with 'git
diff' I didn't see how to do it, but I'm probably just not looking for
the right option...

thanks,

greg k-h
