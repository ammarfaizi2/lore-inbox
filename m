Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVE2S4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVE2S4z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVE2S4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:56:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:31888 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261317AbVE2S4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:56:18 -0400
Date: Sun, 29 May 2005 11:58:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexander Nyberg <alexn@telia.com>
cc: Pete Clements <clem@clem.clem-digital.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc5-git3 fails compile -- acpi_boot_table_init
In-Reply-To: <1117287439.952.17.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0505291157120.10545@ppc970.osdl.org>
References: <200505281206.j4SC6iLa015878@clem.clem-digital.net>
 <1117287439.952.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 May 2005, Alexander Nyberg wrote:
> 
> This is a neverending story
> 
> linux/acpi.h contains empty declarations for acpi_boot_init() &
> acpi_boot_table_init() but they are nested inside #ifdef CONFIG_ACPI.
> 
> So we'll have to #ifdef in arch/i386/kernel/setup.c: setup_arch()

Wouldn't it be much nicer to just fix <linux/acpi.h> instead? Or, if you
really prefer this, then you should remove the now useless code from
acpi.h. In either case, this patch looks wrong.

		Linus
