Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVK1WHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVK1WHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 17:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVK1WHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 17:07:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57554 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751330AbVK1WHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 17:07:20 -0500
Date: Mon, 28 Nov 2005 14:07:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: benh@kernel.crashing.org, mbuesch@freenet.de, stern@rowland.harvard.edu,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Latest GIT: USB ehci_hcd broken (spinlock corruption)
Message-Id: <20051128140704.6a3539f2.akpm@osdl.org>
In-Reply-To: <200511280840.39002.david-b@pacbell.net>
References: <200511271234.27708.mbuesch@freenet.de>
	<1133126726.7768.127.camel@gaston>
	<200511280840.39002.david-b@pacbell.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell <david-b@pacbell.net> wrote:
>
> Rename the EHCI "reset" routine so it better matches what it does (setup);
>  and move the one-time data structure setup earlier, before doing anything
>  that implicitly relies on it having been completed already.
> 
>  --- g26.orig/drivers/usb/host/ehci-pci.c	2005-11-12 10:38:26.000000000 -0800
>  +++ g26/drivers/usb/host/ehci-pci.c	2005-11-28 08:22:59.000000000 -0800

This fixes the hang on my test box.  I don't know if USB still works though..
