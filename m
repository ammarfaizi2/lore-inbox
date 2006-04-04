Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWDDDkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWDDDkG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 23:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWDDDkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 23:40:06 -0400
Received: from nproxy.gmail.com ([64.233.182.190]:24704 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964994AbWDDDkF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 23:40:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ooc2/jz15UBoVLWandkqdNY04Pu0lhlQuSUoPUSUdpV1A36tjpUDvu71fbyis+8QL1e+YR4u+a7aj/AMnj2nHII9nSD3q7Fxoneiy0RxHgXFaL/GzIvdOgklUADsB9bs/1ysqJ47pOILsT8zIUxBI/2trx0C/fQ3HsOPyYcSjdU=
Message-ID: <fc67f8b70604032040y66d14c2ej806f2105d60b9aab@mail.gmail.com>
Date: Mon, 3 Apr 2006 22:40:04 -0500
From: "Ritesh Kumar" <ritesh@cs.unc.edu>
To: "Linux Kernel Development" <linux-kernel@vger.kernel.org>
Subject: Re: vfree with locks held
In-Reply-To: <fc67f8b70604032038m167e333o973c867f93b66faf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <fc67f8b70604032038m167e333o973c867f93b66faf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I am trying to develop a modification of the fifo qdisc for a
small networking project of my own. I need to allocate a significantly
large chunk of memory (about 4M) for every qdisc instance. I used
__vmalloc(size, GFP_ATOMIC, PAGE_KERNEL) for this understanding that
fifo_init (net/sched/sch_fifo.c) is called with locks held. However, I
also need to free this memory up once the qdisc is destroyed. I tried
calling vfree() but it doesn't like being called with locks held. Is
there a way to free this memory with locks held using some variant of
vfree()?

Ritesh


--
This is not an ad. I hate signature ads.
