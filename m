Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbULXEm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbULXEm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 23:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbULXEm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 23:42:29 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:7315 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261369AbULXEm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 23:42:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rnQsAGUxRvWT5oLeRXv6BdzKa4tHU/v1o7Mh0AELx2r7DdngZxwjcEgAXezbd9x1d9ZwwJDnMbmOb5px0fvb5kPikdOTfNj0nGSG0x3vSJsF0XqJTIqFSq+XEn0vVEmoe4JJBvzhb+sEyRkWWOtOecGVgEjVPtk2Lxai/4bslSM=
Message-ID: <8783be660412232042dd372c@mail.gmail.com>
Date: Thu, 23 Dec 2004 23:42:26 -0500
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: DMA problems with 3+ Promise IDE controllers
Cc: Jaco van der Schyff <jvds@netgroup.co.za>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1103845162.15233.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41CB1BE3.465BD490@netgroup.co.za>
	 <1103845162.15233.9.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2004 23:39:24 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Iau, 2004-12-23 at 19:26, Jaco van der Schyff wrote:
> > Any idea how I could get all three cards to work in UDMA100 mode?
> 
> You either need multiple independant PCI busses or to write an
> arbitrator for the IDE DMA layer to ensure that no more than two of the
> three are doing DMA transfers at a time and the other waits.
> 


Could you explain why they can't coexist on the same PCI bus.  The
only problem I see with having all three cards DMA at the same time is
increased latency.  But he's getting CRC errors on the transfer
between the card and the drive, and that doesn't seem like a latency
issue.

I know Promise does funky stuff with their DMA, but I'm curious why no
more than two cards can co-exist on the same PCI bus.

    Ross
