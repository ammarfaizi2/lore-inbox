Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264939AbUD2TlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264939AbUD2TlR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUD2TlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:41:17 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:39812 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264939AbUD2Tk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:40:56 -0400
Date: Thu, 29 Apr 2004 21:41:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Zinx Verituse <zinx@epicsol.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial fix for hid-tmff driver
Message-ID: <20040429194130.GA7960@ucw.cz>
References: <20040429192656.GA13053@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429192656.GA13053@bliss>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 02:26:56PM -0500, Zinx Verituse wrote:
> Well, this has been a problem for quite some time due to a change in
> the list code way back when, and my mails don't seem to be getting
> through to Vojtech Pavlik, so here's the patch..  The problem may still
> exist in the other drivers..

I'll get it into my tree asap.

> 
> -- 
> Zinx Verituse                                    http://zinx.xmms.org/

> diff -ru linux-2.6.5.orig/drivers/usb/input/hid-tmff.c linux-2.6.5/drivers/usb/input/hid-tmff.c
> --- linux-2.6.5.orig/drivers/usb/input/hid-tmff.c	2003-10-25 13:43:59.000000000 -0500
> +++ linux-2.6.5/drivers/usb/input/hid-tmff.c	2003-12-18 01:00:41.000000000 -0600
> @@ -110,7 +110,7 @@
>  {
>  	struct tmff_device *private;
>  	struct list_head *pos;
> -	struct hid_input *hidinput = list_entry(&hid->inputs, struct hid_input, list);
> +	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
>  
>  	private = kmalloc(sizeof(struct tmff_device), GFP_KERNEL);
>  	if (!private)


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
