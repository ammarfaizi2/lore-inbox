Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbVKCD33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbVKCD33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbVKCD32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:29:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751111AbVKCD32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:29:28 -0500
Date: Thu, 3 Nov 2005 13:29:14 +1100
From: Andrew Morton <akpm@osdl.org>
To: Michael Krufky <mkrufky@m1k.net>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH 04/37] dvb: Add ATSC support for DViCO FusionHDTV5 Lite
Message-Id: <20051103132914.64e971b9.akpm@osdl.org>
In-Reply-To: <4367236E.90008@m1k.net>
References: <4367236E.90008@m1k.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
> +static int tdvs_tua6034_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
>  +{
>  +	struct dvb_bt8xx_card *card = (struct dvb_bt8xx_card *) fe->dvb->priv;

The cast of a void* is unneeded.  It's actually undesirable: if someone
were to convert the thing-being-casted to some other scalar type, the cast
would prevent the desired compiler warning.
