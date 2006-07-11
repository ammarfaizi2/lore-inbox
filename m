Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWGKWFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWGKWFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWGKWFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:05:38 -0400
Received: from mail.suse.de ([195.135.220.2]:22214 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932184AbWGKWFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:05:35 -0400
Date: Tue, 11 Jul 2006 15:01:17 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: Opinions on removing /proc/tty?
Message-ID: <20060711220117.GD663@kroah.com>
References: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com> <20060707223043.31488bca.rdunlap@xenotime.net> <9e4733910607072256q65188526uc5cb706ec3ecbaee@mail.gmail.com> <20060708220414.c8f1476e.rdunlap@xenotime.net> <9e4733910607082220v754a000ak7e75ae4042a5e595@mail.gmail.com> <44B0D55D.2010400@gmail.com> <9e4733910607090645l236f17f1sb9778f0fc6c6ca01@mail.gmail.com> <20060709103529.bf8a46a4.rdunlap@xenotime.net> <44B191CF.2090506@gmail.com> <9e4733910607091744k273a7351l16abbcc6ff8c4bbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910607091744k273a7351l16abbcc6ff8c4bbd@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 08:44:24PM -0400, Jon Smirl wrote:
> Much simpler solution:
> 
> cat /sys/class/graphics/fb0/modes
> mode_string
> mode_string
> mode_string
> mode_string
> mode_string
> mode_string
> mode_string
> mode_string
> mode_string
> mode_string
> mode_string
> ...

How do you handle the issue when this file overflows a PAGE_SIZE buffer?

> echo mode_string >/sys/class/graphics/fb0/mode

Yeah, that initially looks very simple, but again, it violates the sysfs
rules.  No matter how stupid you think they are, it still doesn't
matter...

If you really don't like it, make a fbfs, it's only about 200 lines of
code...

thanks,

greg k-h
