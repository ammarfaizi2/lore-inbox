Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVCLTy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVCLTy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 14:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVCLTy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 14:54:57 -0500
Received: from zeus.kernel.org ([204.152.189.113]:54731 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261774AbVCLTyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 14:54:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Nh/SKNlcRP2zdg9tiARLxuiFo/zTr6xUr4ONfitL3DLLb+zk76gPP+Fo0gjvpGzPZe5MkH6UxaZqTUIDrIfirA2jf1FK6fApZz0a2JJa6ztfmmprWSnygkVjX5TUiOR50QMAFOqquCBXdvYMFUT/VDbe++3HtTWW8UXYjhFVrJ4=
Message-ID: <5edf7fc9050312105356a6d0c5@mail.gmail.com>
Date: Sun, 13 Mar 2005 00:23:42 +0530
From: Kedar Sovani <kedars@gmail.com>
Reply-To: Kedar Sovani <kedars@gmail.com>
To: mohanv@aftek.com
Subject: Re: wait queue sharing..
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <423183DE.3020102@aftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <423183DE.3020102@aftek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, technically, you can share the wait queue between two modules.
Ofcourse, provided you can manage to initialise it before any use.

Kedar.

On Fri, 11 Mar 2005 17:11:18 +0530, Mohan <mohanv@aftek.com> wrote:
> Hello All,
> 
> I have a question regarding the wait queues. I have a driver
> pxausb_core.o which is the core driver which does all USB endpoint
> handling and hardware interaction. I have one more driver on top of it
> usb-serial which provides for the user-level interaction(like read,
> write, ioctl).
> I have implemented a blocking ioctl, which sends events about the state
> of USB device(enumerated, suspended, disconnected, etc).
> For this ioctl, i have declared a wait_queue and initialized (using
> init_waitqueue_head() func.) in the usb_ctl.c which is part of
> pxausb_core.o. (it has usb_send.c, usb_recv.c, usb_ctl.c, usb_ep0.c).
> I am using that wait_queue variable in usb-ser.c.
> 
> I just wanted to clarify myself whether the wait queues can be shared
> between two driver modules.
> 
> Thank you...
> regards,
> mohan
