Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWCHLGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWCHLGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWCHLGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:06:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750932AbWCHLGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:06:42 -0500
Date: Wed, 8 Mar 2006 03:04:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm3 doesn't boot on T23 Thinkpad, 2.6.16-rc5-mm2 did
Message-Id: <20060308030449.0f42780c.akpm@osdl.org>
In-Reply-To: <20060308100105.GA6451@amd64.of.nowhere>
References: <20060308100105.GA6451@amd64.of.nowhere>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jurriaan <thunder7@xs4all.nl> wrote:
>
> 2.6.16-rc5-mm3 fails to boot on my IBM T23 thinkpad (P3 1133 MHz, 1 Gb
>  memory). dmesg and .config below.
> 
>  It crashes between these two lines:
> 
>  Checking if this processor honours the WP bit even in supervisor mode... Ok.
>  <crash>
>  Calibrating delay using timer specific routine.. 2266.22 BogoMIPS (lpj=4532447)
> 
>  messages written down from the screen:
> 
>  divide error: 0000 #1
>  EIP is at kmem_cache_init

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/hot-fixes/revert-x86_64-mm-i386-early-alignment.patch
should fix that.

