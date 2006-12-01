Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162254AbWLAXsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162254AbWLAXsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967720AbWLAXsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:48:51 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16010 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S967715AbWLAXsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:48:50 -0500
Date: Fri, 1 Dec 2006 23:55:41 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Martin Mares <mj@ucw.cz>
Subject: Re: [PATCH] Be a bit defensive in quirk_nvidia_ck804() so we don't
 risk dereferencing a NULL pdev.
Message-ID: <20061201235541.7ff63a13@localhost.localdomain>
In-Reply-To: <200612020021.56250.jesper.juhl@gmail.com>
References: <200612020021.56250.jesper.juhl@gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006 00:21:56 +0100
Jesper Juhl <jesper.juhl@gmail.com> wrote:

> pci_get_slot() may return NULL if nothing was found. 
> quirk_nvidia_ck804() does not check the value returned from pci_get_slot(),
> so it may end up causing a NULL pointer deref.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

I don't think its a physically possible case but it does no harm and
it'll kill boot if it happens

Acked-by: Alan Cox <alan@redhat.com>
