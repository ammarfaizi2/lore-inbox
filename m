Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130070AbQLLQLj>; Tue, 12 Dec 2000 11:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131685AbQLLQLa>; Tue, 12 Dec 2000 11:11:30 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:48140 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130070AbQLLQLS>; Tue, 12 Dec 2000 11:11:18 -0500
Date: Tue, 12 Dec 2000 11:40:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Swapping-over-nbd deadlock fixed?
In-Reply-To: <3A3642C6.7D50A6AE@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0012121135010.24789-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Dec 2000, Jeff Garzik wrote:

> I see in the 2.2.18 release notes that a deadlock, related to swapping
> over a network via nbd, was fixed.  Is this bug present in 2.4.x-test?

The bug is not related to swapping via nbd. 

The problem happens because the allocation code (kmalloc) which is called
inside the nbd request function can end up trying to sync dirty buffers,
going to back to the nbd request function.

2.4 is safe. 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
