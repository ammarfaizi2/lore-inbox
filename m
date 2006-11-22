Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757166AbWKVX0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757166AbWKVX0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757169AbWKVX0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:26:16 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39143 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757166AbWKVX0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:26:15 -0500
Date: Wed, 22 Nov 2006 15:25:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
Message-Id: <20061122152559.72efd379.akpm@osdl.org>
In-Reply-To: <1164205742.13434.4.camel@localhost>
References: <1164205742.13434.4.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 15:29:02 +0100
Kasper Sandberg <lkml@metanurb.dk> wrote:

> it appears some sort of bug has gotten into .19, in regards to x86
> emulation on x86_64.
> 
> i have only tested with >=rc5, thw folling, as an example, appears in
> dmesg:
> ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> arg(00221000) on /home/redeeman
> ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32

Try

	echo 0 > /proc/sys/kernel/compat-log

I don't _think_ we did anything to change the logging in there.  Which kernel
version were you using previously (the one which didn't do this)?

