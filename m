Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVIMEns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVIMEns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 00:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVIMEns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 00:43:48 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:4231 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932145AbVIMEnr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 00:43:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s3uBX+ushsor1m/FPOIpnDW0QpFu1+ltfgZSKmsUebVi8q/eKAmZw4gf/cuCX8DAGugLg8SJFYG1S/uvRRDuO9PV191fsJb7Y+Iz5niMABQhHgvHLFeYhN0wT370UyfHbgNBVgPGMYk0JEOk8cIl+C7db1nOHscW2dT1M60kAhM=
Message-ID: <84144f0205091221431827b126@mail.gmail.com>
Date: Tue, 13 Sep 2005 07:43:42 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
Reply-To: Pekka Enberg <penberg@cs.helsinki.fi>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
Cc: Lion Vollnhals <lion.vollnhals@web.de>, linux-kernel@vger.kernel.org
In-Reply-To: <43260817.7070907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509130010.38483.lion.vollnhals@web.de>
	 <43260817.7070907@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/05, Jiri Slaby <jirislaby@gmail.com> wrote:
> >-      cls = kmalloc(sizeof(struct class), GFP_KERNEL);
> >+      cls = kzalloc(sizeof(struct class), GFP_KERNEL);
> >
> >
> maybe, the better way is to write `*cls' instead of `struct class',
> better for further changes

Please note that some maintainers don't like it. I at least could not
sneak in patches like these to drivers/usb/ because I had changed
sizeof.

                                 Pekka
