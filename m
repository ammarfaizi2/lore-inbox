Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268448AbUIPRGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268448AbUIPRGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268118AbUIPRBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:01:52 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:52934 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268490AbUIPRAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:00:12 -0400
Subject: Re: Having problem with mmap system call!!!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0409161050200.12305@chaos>
References: <4EE0CBA31942E547B99B3D4BFAB348111078FE@mail.esn.co.in>
	 <Pine.LNX.4.53.0409160958070.12146@chaos>
	 <1095341494.22744.26.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0409161050200.12305@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095350240.22750.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Sep 2004 16:57:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-16 at 15:54, Richard B. Johnson wrote:
> > SHM_FAIL is the wrong error check btw.
> >
> 
> MAP_FAILED only appeared in real late 'C' runtime library headers.
> That's why the code defines SHM_FAIL, which is also correct, but
> doesn't cause a redefinition error.

SuS doesn't permit the use of SHM_FAIL. And you don't get redefinition
errors if you use ds

> Well that's really nice. Now, how do you do that? The kernel DS
> is not the user DS so you end up with a kernel hack instead of
> a user hack?

Who cares about DS ? the user space page tables get mapped, its how all
mmap functions work. A simple example is the sound drivers (2.4
drivers/sound) which kmalloc a buffer of kernel space then make it
mappable to the user

