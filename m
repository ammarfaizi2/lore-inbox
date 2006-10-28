Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752041AbWJ1KEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbWJ1KEM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 06:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWJ1KEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 06:04:11 -0400
Received: from sp604003mt.neufgp.fr ([84.96.92.56]:34742 "EHLO smTp.neuf.fr")
	by vger.kernel.org with ESMTP id S1752041AbWJ1KEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 06:04:10 -0400
Date: Sat, 28 Oct 2006 12:04:10 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [take21 2/4] kevent: poll/select() notifications.
In-reply-to: <11619654012104@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Message-id: <45432B1A.8020503@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <11619654012104@2ka.mipt.ru>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov a écrit :

> +	file = fget(k->event.id.raw[0]);
> +	if (!file)
> +		return -ENODEV;

Please, do us a favor, and use EBADF instead of ENODEV.

EBADF : /* Bad file number */

ENODEV : /* No such device */

You have many ENODEV uses in your patches and that really hurts.

Eric

