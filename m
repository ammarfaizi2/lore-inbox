Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUFBKtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUFBKtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 06:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUFBKtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 06:49:06 -0400
Received: from [213.146.154.40] ([213.146.154.40]:44781 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261706AbUFBKtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 06:49:03 -0400
Date: Wed, 2 Jun 2004 11:49:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Andrew Morton <akpm@osdl.org>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix dependeces for CONFIG_USB_STORAGE
Message-ID: <20040602104900.GB32474@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paolo Ornati <ornati@fastwebnet.it>, Andrew Morton <akpm@osdl.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <200406021116.35529.ornati@fastwebnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406021116.35529.ornati@fastwebnet.it>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 11:16:35AM +0200, Paolo Ornati wrote:
> This patch adds a missed dependence for CONFIG_USB_STORAGE.
> 
> Signed-off-by: Paolo Ornati <ornati@fastwebnet.it>
> 
> --- linux/drivers/usb/storage/Kconfig.orig	2004-06-02 10:55:18.000000000 +0200
> +++ linux/drivers/usb/storage/Kconfig	2004-06-02 10:56:03.000000000 +0200
> @@ -6,6 +6,7 @@
>  	tristate "USB Mass Storage support"
>  	depends on USB
>  	select SCSI
> +	select BLK_DEV_SD

Huh, why?
