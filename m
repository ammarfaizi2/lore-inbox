Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWEOV7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWEOV7M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbWEOV7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:59:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20693 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964954AbWEOV7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:59:10 -0400
Date: Mon, 15 May 2006 17:59:01 -0400
From: Alan Cox <alan@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Moxa Technologies <support@moxa.com.tw>,
       Alan Cox <alan@redhat.com>, Martin Mares <mj@ucw.cz>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 2/3] moxa: remove pointless check of 'tty' argument vs NULL
Message-ID: <20060515215901.GB16994@devserv.devel.redhat.com>
References: <200605152357.36018.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605152357.36018.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 11:57:35PM +0200, Jesper Juhl wrote:
> Remove pointless check of 'tty' argument vs NULL from moxa driver.

Can you leave those in for the moment but change them to BUG_ON() because
I've seen the pop up once or twice. They may be fixed but Im not 100% sure
yet.

> +	if (!info->xmit_buf)
>  		return (0);

