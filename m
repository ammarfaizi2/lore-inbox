Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUFAVYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUFAVYe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUFAVYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:24:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53896 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265237AbUFAVYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:24:31 -0400
Message-ID: <40BCF3BF.3020202@pobox.com>
Date: Tue, 01 Jun 2004 17:23:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Zabolotny <zap@homelink.ru>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: two patches - request for comments
References: <20040529012030.795ad27e.zap@homelink.ru>	<20040528221006.GB13851@kroah.com> <20040529124421.28c776cc.zap@homelink.ru>
In-Reply-To: <20040529124421.28c776cc.zap@homelink.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Zabolotny wrote:
> No. class_find_device was written for lcd_find_device() and
> backlight_find_device() (framebuffer devices use them). On the other hand,
> the driver that registers the backlight device doesn't have a pointer to the
> class device (well, the lcd_register_device could return it). Since the
> lcd/backlight names are unique anyway, I don't see any problems with that, and
> moreover, it is *registered* by giving it a name, why it should be
> unregistered in a different way?


Typical Linux usage to an item being registered is

	ptr = alloc_foo()
	register_foo(ptr)
	unregister_foo(ptr)
	free_foo()

It is quite unusual to unregister based on name.  Pointers are far more 
likely to be unique, and the programmer is far less likely to screw up 
the unregister operation.

	Jeff


