Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWIRJRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWIRJRH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 05:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWIRJRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 05:17:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37510 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751002AbWIRJRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 05:17:04 -0400
Subject: Re: kmalloc to kzalloc patches for drivers/base
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Om Narasimhan <om.turyx@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
In-Reply-To: <6b4e42d10609171753m2a047081qc2982bf4a693a044@mail.gmail.com>
References: <6b4e42d10609171753m2a047081qc2982bf4a693a044@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Sep 2006 10:40:52 +0100
Message-Id: <1158572453.6069.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-09-17 am 17:53 -0700, ysgrifennodd Om Narasimhan:
> Tested by compiling.
> 
> Signed off by Om Narasimhan <om.turyx@gmail.com>

> -	if (!(retval = kmalloc (sizeof *retval, SLAB_KERNEL)))
> +	if (!(retval = kzalloc (sizeof *retval, SLAB_KERNEL)))
>  		return retval;


NAK

Why slow all these allocations down when they don't zero the memory
anyway ?

