Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbUKVW6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUKVW6V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbUKVW4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:56:53 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:57075 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261211AbUKVWxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:53:52 -0500
Date: Mon, 22 Nov 2004 14:53:35 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v1][11/12] Add InfiniBand Documentation files
Message-ID: <20041122225335.GE15634@kroah.com>
References: <20041122714.taTI3zcdWo5JfuMd@topspin.com> <20041122714.AyIOvRY195EGFTaO@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122714.AyIOvRY195EGFTaO@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 07:14:22AM -0800, Roland Dreier wrote:
> +/dev files
> +
> +  To create the appropriate character device files automatically with
> +  udev, a rule like
> +
> +    KERNEL="umad*", NAME="infiniband/%s{ibdev}/ports/%s{port}/mad"
> +
> +  can be used.  This will create a device node named
> +
> +    /dev/infiniband/mthca0/ports/1/mad
> +
> +  for port 1 of device mthca0, and so on.

Why do you propose such a "deep" nesting of directories for umad
devices?  That's not the LANNANA way.

Oh, have you asked for a real major number to be reserved for umad?

thanks,

greg k-h
