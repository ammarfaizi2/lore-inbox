Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423071AbWAMWyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423071AbWAMWyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423072AbWAMWyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:54:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27609 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423071AbWAMWyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:54:19 -0500
Date: Fri, 13 Jan 2006 14:52:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kumar Gala <galak@gate.crashing.org>
Cc: wim@iguana.be, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       iinuxppc-embedded@gate.crashing.org, dave@cray.org, paulus@samba.org
Subject: Re: [PATCH] powerpc: Add support for the MPC83xx watchdog
Message-Id: <20060113145259.6d38e296.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0601131618020.26648-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0601131618020.26648-100000@gate.crashing.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala <galak@gate.crashing.org> wrote:
>
> Added support for the PowerPC MPC83xx watchdog.  The MPC83xx has a simple
> watchdog that once enabled it can not be stopped, has some simple timeout
> range selection, and the ability to either reset the processor or take
> a machine check.
> 
>
> +static ushort timeout = 0xffff;

There's no such thing ;)  I'll change this to u16, OK?


> +static int mpc83xx_wdt_ioctl(struct inode *inode, struct file *file,
> +			     unsigned int cmd,
> +	unsigned long arg)

Whitespace went nutty in various places.  I'll fix that up.  Please see the
followup patch.

