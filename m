Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTKRInn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 03:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTKRInn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 03:43:43 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21256 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262052AbTKRInm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 03:43:42 -0500
Date: Tue, 18 Nov 2003 08:43:36 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: use ELF sections for get_wchan()
Message-ID: <20031118084336.A28004@flint.arm.linux.org.uk>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031118074448.GD19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031118074448.GD19856@holomorphy.com>; from wli@holomorphy.com on Mon, Nov 17, 2003 at 11:44:48PM -0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of comments on the patch:

> diff -prauN linux-2.6.0-test9-bk22/arch/arm/boot/compressed/vmlinux.lds.in wchan-2.6.0-test9-bk22-1/arch/arm/boot/compressed/vmlinux.lds.in
> --- linux-2.6.0-test9-bk22/arch/arm/boot/compressed/vmlinux.lds.in	2003-10-25 11:43:32.000000000 -0700
> +++ wchan-2.6.0-test9-bk22-1/arch/arm/boot/compressed/vmlinux.lds.in	2003-11-17 23:14:03.000000000 -0800

You don't need to add to this file - this linker script takes the binary
kernel image and puts the necessary decompressor magic around it.

> diff -prauN linux-2.6.0-test9-bk22/arch/arm26/boot/compressed/vmlinux.lds.in wchan-2.6.0-test9-bk22-1/arch/arm26/boot/compressed/vmlinux.lds.in
> --- linux-2.6.0-test9-bk22/arch/arm26/boot/compressed/vmlinux.lds.in	2003-10-25 11:42:57.000000000 -0700
> +++ wchan-2.6.0-test9-bk22-1/arch/arm26/boot/compressed/vmlinux.lds.in	2003-11-17 23:09:47.000000000 -0800

Same again.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
