Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVB1A10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVB1A10 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVB1A1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:27:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64398 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261254AbVB1AZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 19:25:29 -0500
Message-ID: <422264E7.1030602@pobox.com>
Date: Sun, 27 Feb 2005 19:25:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wen Xiong <wendyx@us.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [ patch 2/7] drivers/serial/jsm: new serial device driver
References: <42225A04.7080505@us.ltcfwd.linux.ibm.com>
In-Reply-To: <42225A04.7080505@us.ltcfwd.linux.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wen Xiong wrote:
> +#define TMPBUFLEN (1024)
> +
> +/*
> + * jsm_sniff - Dump data out to the "sniff" buffer if the
> + * proc sniff file is opened...
> + */
> +
> +void jsm_sniff_nowait_nolock(struct channel_t *ch, uchar *text, uchar *buf, int len)
> +{
> +	struct timeval tv;
> +	int n;
> +	int r;
> +	int nbuf;
> +	int i;
> +	int tmpbuflen;
> +	char tmpbuf[TMPBUFLEN];

Uses WAY too much stack space.

	Jeff


