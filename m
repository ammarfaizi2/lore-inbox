Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWAILbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWAILbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 06:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWAILbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 06:31:10 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:52544 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751220AbWAILbJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 06:31:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ck806Ytbdy5HsgH9XshQOQYpD7pxdcPg/J5X/xWK8eL9B20SqzzRGN3cJNhSAhmSlypT6mlj4m0Tthao6TMl8Jq2iNCK1uxK2rJ7+v+caH/oe/rtxVUZ0vFH5cZMiZ6Q5PV8gMlAkxTAX07mwDHQZhchLVrMsGf7iq/c8cii0nA=
Message-ID: <39e6f6c70601090331g3eaa4b0ge3b8102e94a7af65@mail.gmail.com>
Date: Mon, 9 Jan 2006 09:31:08 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] net: 32 bit (socket layer) ioctl emulation for 64 bit kernels
Cc: spereira@tusc.com.au, linux-kenel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>, Andi Kleen <ak@muc.de>,
       SP <pereira.shaun@gmail.com>
In-Reply-To: <200601091054.35010.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1136789216.6653.17.camel@spereira05.tusc.com.au>
	 <200601091054.35010.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 09 January 2006 06:46, Shaun Pereira wrote:

> > Since we are interested in ioctl's from userspace I have not added the
> > .compat_ioctl function pointer to struct net_device. The assumption
> > being once the userspace data has reached the kernel via the socket api,
> > if the socket layer protocol knows how to handle the data, it will
> > prepare it for the device.
>
> I think we need to have it in the long run, but if you don't need it
> for x25, then it's not your call to implement net_device->compat_ioctl.
> I've been thinking about how to get it right before, but did not
> reach a proper conclusion, since dev_ioctl is called in so many places
> that would all need to be changed for this.

Nowadays dev_ioctl is only called from one funcion: sock_ioctl in
net/socket.c, this is after a recent changeset by hch.

- Arnaldo
