Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTJXFmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 01:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbTJXFmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 01:42:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:60314 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262001AbTJXFm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 01:42:29 -0400
Date: Thu, 23 Oct 2003 22:41:46 -0700
From: Greg KH <greg@kroah.com>
To: David Jez <dave.jez@seznam.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: diethotplug-0.4 utility patch
Message-ID: <20031024054145.GA3233@kroah.com>
References: <20031023184603.GA81234@stud.fit.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023184603.GA81234@stud.fit.vutbr.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 08:46:11PM +0200, David Jez wrote:
>   Hi Greg,
> 
>   I send you patch for diethotplug-0.4, witch:
> - adds remove action

Hm, remove action will not work.  See the linux-hotplug-devel mailing
list archives for why we can not do this.

> - adds pci.rc & usb.rc

Why do you need this?  What's wrong with a small shell script to do
this?  Are you using this for a system?  I guess it could be useful for
a system that has no shell.

> - usb.rc script remove modules not by fixed list as hotplug, but from
>   list gotten from depend files when compiled

I don't understand, what does this do?

> - for USB: matching by vendor & class, not only by vendor (-ENODEV bug)

Can you split this patch out?  It looks useful.

> +++ diethotplug-0.4/convert_ieee1394.pl	Thu Apr 10 11:16:00 2003
> @@ -54,4 +54,3 @@
>  }
>  
>  print "\t{NULL}\n};\n";
> -

Hm, you have a few diffs like this, I don't think it's really necessary
:)

thanks,

greg k-h
