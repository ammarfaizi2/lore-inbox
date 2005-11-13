Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVKMS4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVKMS4M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 13:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVKMS4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 13:56:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750704AbVKMS4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 13:56:12 -0500
Date: Sun, 13 Nov 2005 10:55:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [partial patch] 2.6.14-mm2 bugs and fixes
Message-Id: <20051113105552.68705c3c.akpm@osdl.org>
In-Reply-To: <200511131441.18443.bero@arklinux.org>
References: <200511131441.18443.bero@arklinux.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
>
> Some problems with 2.6.14-mm2, and fixes for some:
> 
> drivers/input/power.ko needs unresolved symbol PM_IS_ACTIVE -- needs to either include <linux/pm_legacy.h> or remove the usage -- attached patch #1 does the latter.

Thanks.

> drivers/usb/core/message.c no longer exports usb_get_string, this breaks some external drivers (probably most notably ndiswrapper) -- attached patch #2 reverts this.

Agree.  We shouldn't be ripping out exported symbols with zero notice like
this.  We have a process for doing this.

