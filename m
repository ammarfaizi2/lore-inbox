Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSKXOw6>; Sun, 24 Nov 2002 09:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSKXOw6>; Sun, 24 Nov 2002 09:52:58 -0500
Received: from services.cam.org ([198.73.180.252]:15637 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S261338AbSKXOw6>;
	Sun, 24 Nov 2002 09:52:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andi Kleen <ak@muc.de>
Subject: Re: Invalid module format - how does one fix this?
Date: Sun, 24 Nov 2002 09:59:33 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200211240859.35516.tomlins@cam.org> <m3vg2nniym.fsf@averell.firstfloor.org>
In-Reply-To: <m3vg2nniym.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211240959.33829.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 24, 2002 09:25 am, Andi Kleen wrote:
> Ed Tomlinson <tomlins@cam.org> writes:
> > FATAL: Error inserting /lib/modules/2.5.49-mm1/kernel/ac97_codec.o:
> > Invalid module format
> >
> > I get this on about 10% of the modules I want to load.  How do I fix it?
>
> readelf -r module_in_question.o
>
> then look at arch/$ARCH/kernel/module.c and find out which relocation
> is not implemented. Then implement it. Enabling DEBUGP there and in
> kernel/module.c may also help.

Looking in i386/kernel/module.c, it should be using printk to tell me
what is missing.  I am not seeing these in my logs.  Is there some /proc or
/sys setting I need to change to see warnings?

Tia,
Ed Tomlinson
