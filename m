Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVAUIfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVAUIfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVAUIfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:35:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:8597 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262315AbVAUIfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:35:16 -0500
Date: Fri, 21 Jan 2005 00:34:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm2
Message-Id: <20050121003449.75ec1397.akpm@osdl.org>
In-Reply-To: <41F0B807.6000606@kolivas.org>
References: <20050119213818.55b14bb0.akpm@osdl.org>
	<41F0B807.6000606@kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Stops after BIOS check successful.

What does this mean, btw?  Can you be more specific about where it gets
stuck?

If you mean that it actually prints no messages at all then yeah, early
printk.  One suspect would be the kexec patches which play with boot-time
memory layouts and such.

Make sure that CONFIG_PHYSICAL_START is 0x100000.

x86-vmlinux-fix-physical-addrs.patch, perhaps..
