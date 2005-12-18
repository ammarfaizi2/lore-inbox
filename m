Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965260AbVLRTzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbVLRTzV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 14:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbVLRTzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 14:55:21 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:53142 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S965260AbVLRTzT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 14:55:19 -0500
Date: Sun, 18 Dec 2005 20:23:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 13/13]  [RFC] ipath Kconfig and Makefile
Message-ID: <20051218192356.GB9145@mars.ravnborg.org>
References: <200512161548.MdcxE8ZQTy1yj4v1@cisco.com> <200512161548.lokgvLraSGi0enUH@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512161548.lokgvLraSGi0enUH@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 03:48:55PM -0800, Roland Dreier wrote:
> @@ -0,0 +1,15 @@
> +EXTRA_CFLAGS += -Idrivers/infiniband/include
If this is needed then some header files should be moved to include/rdma

> +
> +ipath_core-objs := ipath_copy.o ipath_driver.o \
> +	ipath_dwordcpy.o ipath_ht400.o ipath_i2c.o ipath_layer.o \
> +	ipath_lib.o ipath_mlock.o
> +
> +ib_ipath-objs := ipath_mad.o ipath_verbs.o

Please use:
ipath_core-y := ...
ib_ipath-y   := ...

Use of -y let you do better Kconfig selection in the makefile, and is
preferred compared to -objs

	Sam
