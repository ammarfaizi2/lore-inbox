Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbUKVTpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbUKVTpa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbUKVTgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:36:42 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:8220 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S263350AbUKVTdq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:33:46 -0500
Date: Mon, 22 Nov 2004 20:33:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA (Subnet Administration) query support
Message-ID: <20041122193350.GB8150@mars.ravnborg.org>
Mail-Followup-To: Roland Dreier <roland@topspin.com>,
	linux-kernel@vger.kernel.org, openib-general@openib.org
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com> <20041122713.g6bh6aqdXIN4RJYR@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122713.g6bh6aqdXIN4RJYR@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nitpicking.

	Sam
	
> --- linux-bk.orig/drivers/infiniband/core/Makefile	2004-11-21 21:25:53.101323036 -0800
> +++ linux-bk/drivers/infiniband/core/Makefile	2004-11-21 21:25:53.879207651 -0800
> @@ -2,7 +2,8 @@
>  
>  obj-$(CONFIG_INFINIBAND) += \
>      ib_core.o \
> -    ib_mad.o
> +    ib_mad.o \
> +    ib_sa.o
It's more readable to keep .o files on one line.


>  
>  ib_core-objs := \
>      packer.o \

For new stuff please use ib_core-y :=

> @@ -17,3 +18,5 @@
>      mad.o \
>      smi.o \
>      agent.o
> +
> +ib_sa-objs := sa_query.o
ib_sa-y := please.

> +#include <linux/idr.h>
> +
> +#include <ib_pack.h>
> +#include <ib_sa.h>
If they are in same dir as .c file use:
#include "ib_pack.h"
#include "ib_sa.h"

> Index: linux-bk/drivers/infiniband/include/ib_sa.h

.h files for a subsystem like this ought to be placed in include/infiniband
if they will be used by files in other directories than drivers/infiniband


