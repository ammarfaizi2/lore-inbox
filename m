Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265791AbUBGBKw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUBGBKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:10:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1669 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265791AbUBGBKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:10:51 -0500
Date: Sat, 7 Feb 2004 01:10:48 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: James Simmons <jsimmons@infradead.org>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbdev sysfs support.
Message-ID: <20040207011047.GR21151@parcelfarce.linux.theplanet.co.uk>
References: <20040207005954.GB4492@kroah.com> <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 01:01:35AM +0000, James Simmons wrote:
> +static void release_fb_info(struct class_device *class_dev)
> +{
> +	struct fb_info *info = to_fb_info(class_dev);
> +
> +	/* This doesn't harm */
> +	fb_dealloc_cmap(&info->cmap);
> +
> +	kfree(info);
> +}

So what has happens when we hit existing kfree() on fb_info while sysfs
node is busy?
