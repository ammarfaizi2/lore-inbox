Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbTHWJju (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 05:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbTHWJju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 05:39:50 -0400
Received: from imf.math.ku.dk ([130.225.103.32]:35304 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S263787AbTHWJjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 05:39:48 -0400
Date: Sat, 23 Aug 2003 11:39:44 +0200 (CEST)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6] Synaptics: support reconnect keeping the same input
 device
In-Reply-To: <200308230131.57111.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.40.0308231132250.13605-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 23 Aug 2003, Dmitry Torokhov wrote:

> Here is the update to the Synaptics touchpad driver. It is supposed to go
> on top of patches form Peter Osterlund site:

> +	if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)) {
>  		switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
>  		default:
>  			printk(KERN_ERR "This touchpad reports more than 8 multi-buttons, don't know how to handle.\n");
>  		case 8:
...
>  		case 6:
>  		case 4:
>  		case 2:
>  		}

I think a break is needed after the default case as the documentation says
"If nExtBtm is greater than 8 ... nExtbtm should be considered to be
invalid and treated as zero."

Peter


