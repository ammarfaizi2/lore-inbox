Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTGFPYB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 11:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbTGFPYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 11:24:01 -0400
Received: from asplinux.ru ([195.133.213.194]:28168 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S262179AbTGFPYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 11:24:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kirill Korotaev <dev@sw.ru>
Organization: SW Soft
To: gigag@bezeqint.net
Subject: Re: Patch for 3.5/0.5 address space split
Date: Sun, 6 Jul 2003 19:47:49 +0400
User-Agent: KMail/1.4.2
References: <bac2312a.9f399e92.8177000@mas3.bezeqint.net>
In-Reply-To: <bac2312a.9f399e92.8177000@mas3.bezeqint.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307061947.49393.dev@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could anybody point out to patches available for 3.5/0.5 address
> space split for 2.4 and 2.5 kernels?
> Any other working options? I managed to compile 2.4.21 kernel
> with 1/3 split, but not with 0.5/3.5. The last one simply doesn't
> boot. What could I be doing wrong?

As far as I remember I saw some places in the code which should be fixed 
before split 1/3 can be used. Split 0.5/3.5 can be not-working if you are 
using PAE-enabled kernel (in some places pgds are copied directly - i.e. 1GB 
granularity is used).

Anyway due to bug in glibc pthread lib some apps are not working properly with 
non-standart 3/1 split (i.e. java).

I'm working on 4GB/4GB split now (kernel space is separated from user space 
completely). If someone wants to have a look at it I will probably post it 
later.

Kirill

