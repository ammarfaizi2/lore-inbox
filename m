Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTISXb6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 19:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTISXb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 19:31:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:46984 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261836AbTISXb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 19:31:57 -0400
Date: Fri, 19 Sep 2003 16:32:18 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] RFC: Attributes in /sys/cdev
Message-ID: <20030919233218.GF7808@kroah.com>
References: <20030919231046.4626.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919231046.4626.qmail@lwn.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 05:10:46PM -0600, Jonathan Corbet wrote:
> +static ssize_t cdev_dev_read(struct cdev *cd, char *page)
> +{
> +	return sprintf(page, "%d:%d\n", MAJOR(cd->firstdev),
> +			MINOR(cd->firstdev));
> +}

You should use the print_dev_t() call here instead of doing it by hand.

thanks,

greg k-h
