Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbVINQK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbVINQK3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbVINQK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:10:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51925 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030224AbVINQK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:10:28 -0400
Date: Wed, 14 Sep 2005 17:10:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, rbh00@utsglobal.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/7] s390: 3270 fullscreen view.
Message-ID: <20050914161022.GA4230@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	rbh00@utsglobal.com, linux-kernel@vger.kernel.org
References: <20050914155345.GA11478@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914155345.GA11478@skybase.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 05:53:45PM +0200, Martin Schwidefsky wrote:
> [patch 2/7] s390: 3270 fullscreen view.
> 
> From: Richard Hitt <rbh00@utsglobal.com>
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Fix fullscreen view of the 3270 device driver.
> 
> Signed-off-by: Richard Hitt <rbh00@utsglobal.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> diffstat:
>  arch/s390/kernel/compat_ioctl.c |    9 +
>  drivers/s390/char/con3270.c     |    7 -
>  drivers/s390/char/fs3270.c      |  234 +++++++++++++++++++++++++++++++++-------
>  drivers/s390/char/raw3270.c     |  100 +++++++++++++++--
>  drivers/s390/char/raw3270.h     |    7 +
>  drivers/s390/char/tty3270.c     |   27 ++--
>  6 files changed, 315 insertions(+), 69 deletions(-)
> 
> diff -urpN linux-2.6/arch/s390/kernel/compat_ioctl.c linux-2.6-patched/arch/s390/kernel/compat_ioctl.c
> --- linux-2.6/arch/s390/kernel/compat_ioctl.c	2005-08-29 01:41:01.000000000 +0200
> +++ linux-2.6-patched/arch/s390/kernel/compat_ioctl.c	2005-09-14 16:48:15.000000000 +0200
> @@ -18,6 +18,8 @@
>  #include <asm/dasd.h>
>  #include <asm/cmb.h>
>  #include <asm/tape390.h>
> +#include <asm/ccwdev.h>
> +#include "../../../drivers/s390/char/raw3270.h"

Umm, no.  Please implement a compat_ioctl methods for the driver instead.
a volunteer ;-)

