Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUKQEQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUKQEQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 23:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUKQEQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 23:16:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3798 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262206AbUKQEQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 23:16:34 -0500
Date: Tue, 16 Nov 2004 23:16:18 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jesper Juhl <juhl@dif.dk>
cc: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <davem@davemloft.net>
Subject: Re: [PATCH 1/2] - net/socket.c::sys_bind() cleanup.
In-Reply-To: <Pine.LNX.4.61.0411170109020.3444@dragon.hygekrogen.localhost>
Message-ID: <Xine.LNX.4.44.0411162315420.29418-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004, Jesper Juhl wrote:

> Not exactely : 
> 
> 
> > -		if((err=move_addr_to_kernel(umyaddr,addrlen,address))>=0) {
> 
> > +	err = move_addr_to_kernel(umyaddr, addrlen, address);
> > +	if (err)
> > +		goto out_put;
> 
> 
> The original tests for err >= 0, your replacement tests if err is != 0

Look at move_addr_to_kernel(), it only returns 0 or -error.

The patch looks good to me.


- James
-- 
James Morris
<jmorris@redhat.com>


