Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVKEFCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVKEFCY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 00:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVKEFCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 00:02:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751260AbVKEFCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 00:02:23 -0500
Date: Fri, 4 Nov 2005 21:02:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfsplus: don't modify journaled volume
Message-Id: <20051104210213.1232a007.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511031617090.12843@scrub.home>
References: <Pine.LNX.4.61.0511031617090.12843@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> +		} else if (vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_JOURNALED)) {
>  +			printk("HFS+-fs: Filesystem is marked journaled, leaving read-only.\n");
>  +			sb->s_flags |= MS_RDONLY;
>  +			*flags |= MS_RDONLY;

These sorts of printks should have an explicit facility level, no?
