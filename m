Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWEGTUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWEGTUB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 15:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWEGTUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 15:20:00 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:5066 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932079AbWEGTUA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 15:20:00 -0400
Subject: Re: [PATCH] Bluetooth: fix potential NULL ptr deref in
	dtl1_cs.c::dtl1_hci_send_frame()
From: Marcel Holtmann <marcel@holtmann.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605072050.57415.jesper.juhl@gmail.com>
References: <200605072050.57415.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Sun, 07 May 2006 21:21:16 +0200
Message-Id: <1147029676.11328.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper,

> There's a problem in drivers/bluetooth/dtl1_cs.c::dtl1_hci_send_frame()
> 
> If bt_skb_alloc() returns NULL, then skb_reserve(s, NSHL); will cause a
> NULL pointer deref - ouch.
> If we can't allocate the resources we require we need to tell the caller
> by returning -ENOMEM.
> 
> Found by the coverity checker as bug #409
> 
> Patch is compile tested, but that's all, due to lack of hardware.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


