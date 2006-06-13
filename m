Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWFMUS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWFMUS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWFMUS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:18:58 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:37101 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932076AbWFMUS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:18:57 -0400
Date: Tue, 13 Jun 2006 22:18:55 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: John Richard Moser <nigelenki@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Packing data in kernel memory
In-Reply-To: <448F0893.1080706@comcast.net>
Message-ID: <Pine.LNX.4.61.0606132217110.11918@yvahk01.tjqt.qr>
References: <448F0893.1080706@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Subject: Packing data in kernel memory
>

Can't you just use mlock(), if you want to keep it in RAM?

Or do you need it in kernel memory, because you need it in the lowmem area? 
Or for interaction with other kernel code?

>Is there a way to pack and store arbitrary data in the kernel, or do I
>need to roll my own?
>

Write a device driver, kmalloc some buffer, and copy data via a write 
function from userspace to that buffer. Should be trivial.

>1 excess pages, 4 units wasted memory.

Of course, kmalloc only works up to some boundary AFIACS.


Jan Engelhardt
-- 
