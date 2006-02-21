Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWBUSes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWBUSes (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWBUSeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:34:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:50661 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932548AbWBUSeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:34:15 -0500
Date: Tue, 21 Feb 2006 09:56:40 -0800
From: Greg KH <greg@kroah.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [ PATCH 2.6.16-rc3-xen 1/3] sysfs: export Xen hypervisor attributes to sysfs
Message-ID: <20060221175640.GA23075@kroah.com>
References: <43FB2573.3070909@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FB2573.3070909@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 09:36:35AM -0500, Mike D. Day wrote:
> 		+---properties
> 			+---changeset

Just curious, but what is a "changeset"?

> The xen_sysfs module has a tri-state Kconfig so it can be built-in or
> loaded as a module.
> 
> The module is in three patches: 

This patch has it's leading spaces eaten by your email client and can
not be applied :(

> diff -r a05e56904e7e -r d296aaf07bcb xen/include/public/version.h
> --- a/xen/include/public/version.h	Mon Feb 20 23:01:50 2006 +0000
> +++ b/xen/include/public/version.h	Tue Feb 21 08:11:03 2006 -0500
> @@ -1,8 +1,8 @@
> /******************************************************************************
> * version.h
> - * 
> + *
> * Xen version, type, and compile information.
> - * 
> + *
> * Copyright (c) 2005, Nguyen Anh Quynh <aquynh@gmail.com>
> * Copyright (c) 2005, Keir Fraser <keir@xensource.com>
> */
> @@ -17,6 +17,7 @@
> 
> /* arg == xen_extraversion_t. */
> #define XENVER_extraversion 1
> +#define XENVER_EXTRAVERSION_LEN 16
> typedef char xen_extraversion_t[16];

Shouldn't the typedef use the #define in it, so that if you change it,
the array size is properly changed too?

thanks,

greg k-h
