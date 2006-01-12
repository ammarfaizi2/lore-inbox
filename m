Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWALDwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWALDwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 22:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWALDwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 22:52:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34254 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751190AbWALDwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 22:52:21 -0500
Date: Wed, 11 Jan 2006 19:51:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, mkrufky@m1k.net, mchehab@infradead.org
Subject: Re: [PATCH 05/20] V4L/DVB (3343) Add support for DViCO FusionHDTV
 DVB-T USB devices
Message-Id: <20060111195137.4132424f.akpm@osdl.org>
In-Reply-To: <20060112025552.PS20388000005@infradead.org>
References: <20060112025516.PS38541900000@infradead.org>
	<20060112025552.PS20388000005@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@infradead.org wrote:
>
> +	.urb = {
>  +		.type = DVB_USB_BULK,
>  +		.count = 5,
>  +		.endpoint = 0x04,
>  +		.u = {
>  +			.bulk = {
>  +				.buffersize = 8192,
>  +			}
>  +		}
>  +	},

Note that we don't need to go through this pain any more.  With the
gcc-2.95 abandonment we can do

	.u.bulk.buffersize = 8192;
