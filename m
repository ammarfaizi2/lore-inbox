Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUDSSc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 14:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbUDSSc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 14:32:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29101 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261678AbUDSSc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 14:32:57 -0400
Message-ID: <40841B4B.4090102@pobox.com>
Date: Mon, 19 Apr 2004 14:32:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Jochens <aj@andaco.de>, "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tg3 driver - address error in TSO firmware code
References: <20040418135534.GA6142@andaco.de> <20040418180811.0b2e2567.davem@redhat.com> <20040419080439.GB11586@andaco.de> <4083F5CE.5080008@pobox.com> <20040419181238.GA5987@andaco.de>
In-Reply-To: <20040419181238.GA5987@andaco.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jochens wrote:
> diff -urN linux-2.6.5.orig/drivers/net/tg3.c linux-2.6.5/drivers/net/tg3.c
> --- linux-2.6.5.orig/drivers/net/tg3.c	2004-04-03 21:37:23.000000000 -0600
> +++ linux-2.6.5/drivers/net/tg3.c	2004-04-19 12:47:09.254148712 -0500
> @@ -3842,7 +3842,7 @@
>  #define TG3_TSO_FW_START_ADDR		0x08000000
>  #define TG3_TSO_FW_TEXT_ADDR		0x08000000
>  #define TG3_TSO_FW_TEXT_LEN		0x1a90
> -#define TG3_TSO_FW_RODATA_ADDR		0x08001a900
> +#define TG3_TSO_FW_RODATA_ADDR		0x08001a90
>  #define TG3_TSO_FW_RODATA_LEN		0x60
>  #define TG3_TSO_FW_DATA_ADDR		0x08001b20
>  #define TG3_TSO_FW_DATA_LEN		0x20


Agreed this is a bug, good spotting.

David, want to merge this one?

	Jeff



