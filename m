Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUBGBXa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265836AbUBGBXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:23:30 -0500
Received: from mail.kroah.org ([65.200.24.183]:48091 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265823AbUBGBXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:23:16 -0500
Date: Fri, 6 Feb 2004 17:23:13 -0800
From: Greg KH <greg@kroah.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbdev sysfs support.
Message-ID: <20040207012313.GF4492@kroah.com>
References: <20040207005954.GB4492@kroah.com> <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 01:01:35AM +0000, James Simmons wrote:
> +static ssize_t show_dev(struct class_device *class_dev, char *buf)
> +{
> +	struct fb_info *info = to_fb_info(class_dev);
> +
> +	return sprintf(buf, "%u:%u\n", FB_MAJOR, info->node);
> +}

Another ick.  Please use the already present function for this,
print_dev_t().

thanks,

greg k-h
