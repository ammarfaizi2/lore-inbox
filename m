Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVGWWkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVGWWkE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 18:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVGWWkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 18:40:04 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:50781 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262053AbVGWWkA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 18:40:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IRknVhYT0hkbux8fAk6FdDevyjuOkhid1ZungnZIKrS89Mu0WQJHdbtbLK1VSBm7URORHXRqXait5yS1SJLgZyWKuzgoboGLHVwUtu0/7oabJQq+t8r/+E7wG7u+a+FgXlD4ZK6XyYzrTjxOESWyCl5ddSZR+T0NKVdH3y4dSyE=
Message-ID: <21d7e997050723154057d36290@mail.gmail.com>
Date: Sun, 24 Jul 2005 08:40:00 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: fix suspend/resume irq request free for yenta..
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>
In-Reply-To: <Pine.LNX.4.61.0507230941280.16055@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0507222331580.15287@skynet>
	 <200507221816.19424.dtor_core@ameritech.net>
	 <20050723002924.GA1988@elf.ucw.cz>
	 <20050723084049.A7921@flint.arm.linux.org.uk>
	 <Pine.LNX.4.61.0507230941280.16055@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.
> >
> > What if some other driver is sharing the IRQ, and requires IRQs to be
> > enabled for the resume to complete?

All drivers re-enable IRQs on their way back up in their resume code,
they shouldn't be doing anything before that point..

> This certainly is the case on many laptops.

Well at the moment on my laptop without this patch we don't make it
back, and we've done a lot of talking at OLS about this.. patches like
this will be popping up for most drivers soon....

Dave.
