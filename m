Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbTE2JbR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 05:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTE2JbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 05:31:17 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:10505 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262031AbTE2JbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 05:31:16 -0400
Date: Thu, 29 May 2003 10:30:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org, greg@kroah.com
Subject: Re: [RFT/C 2.5.70] Input class hook up to driver model/sysfs
Message-ID: <20030529103008.A15630@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
	mochel@osdl.org, greg@kroah.com
References: <175110000.1054083891@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <175110000.1054083891@w-hlinder>; from hannal@us.ibm.com on Tue, May 27, 2003 at 06:04:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 06:04:51PM -0700, Hanna Linder wrote:
>  static void evdev_free(struct evdev *evdev)
>  {
> -	devfs_remove("input/event%d", evdev->minor);
> +	input_unregister_class_dev("input/event%d", evdev->minor);

Please don't mix up devfs and LDM stuff.  devfs uses very strange
devices and having them anywhere without the devfs_ prefix that should
act as a big CAUTION sign is bad.

