Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVAHFV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVAHFV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 00:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVAHFV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 00:21:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:47847 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261786AbVAHFVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:21:11 -0500
Date: Fri, 7 Jan 2005 21:07:29 -0800
From: Greg KH <greg@kroah.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] add support for sysdev class attributes
Message-ID: <20050108050729.GA7587@kroah.com>
References: <1105136891.13391.20.camel@pants.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105136891.13391.20.camel@pants.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 04:28:12PM -0600, Nathan Lynch wrote:
> @@ -88,6 +123,12 @@ int sysdev_class_register(struct sysdev_
>  	INIT_LIST_HEAD(&cls->drivers);
>  	cls->kset.subsys = &system_subsys;
>  	kset_set_kset_s(cls, system_subsys);
> +
> +	/* I'm not going to claim to understand this; see
> +	 * fs/sysfs/file::check_perm for how sysfs_ops are selected
> +	 */
> +	cls->kset.kobj.ktype = &sysdev_class_ktype;
> +

I think you need to understand this, and then submit a patch without
such a comment :)

And probably without such code, as I don't think you need to do that.

thanks,

greg k-h
