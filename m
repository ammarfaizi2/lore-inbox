Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbUAHBdj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUAHBcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:32:25 -0500
Received: from dp.samba.org ([66.70.73.150]:4760 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263057AbUAHBcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:32:09 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: block-major aliases (module-init-tools 3.0-pre2) 
In-reply-to: Your message of "Wed, 07 Jan 2004 13:40:54 +0300."
             <200401071340.54983.arvidjaar@mail.ru> 
Date: Thu, 08 Jan 2004 11:39:52 +1100
Message-Id: <20040108013207.0CA292C237@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200401071340.54983.arvidjaar@mail.ru> you write:
> Apparently generate-modprobe.conf is producing block-major-N-* while kernel 
> (2.6.0) still calls request_module with block-major-N:
> 
> {pts/0}% grep request_module drivers/block/*
> drivers/block/genhd.c:  request_module("block-major-%d", MAJOR(dev));
> 
> who is correct?

The former, but patch didn't make it into 2.6.0.  Fix (which does
both, due to the confusion) is in -rc2.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
