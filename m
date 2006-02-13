Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWBMAOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWBMAOS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWBMAOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:14:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751495AbWBMAOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:14:17 -0500
Date: Sun, 12 Feb 2006 16:13:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roger Leigh <rleigh@whinlatter.ukfsn.org>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       debian-powerpc@lists.debian.org
Subject: Re: 2.6.16-rc2 powerpc timestamp skew
Message-Id: <20060212161326.279fcb9f.akpm@osdl.org>
In-Reply-To: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Leigh <rleigh@whinlatter.ukfsn.org> wrote:
>
> When running a 2.6.16-rc2 kernel on a powerpc system (Mac Mini;
>  Freescale 7447A):
> 
>  $ date && touch f && ls -l f && rm -f f && date
>  Sun Feb 12 12:20:14 GMT 2006
>  -rw-r--r-- 1 rleigh rleigh 0 2006-02-12 12:23
>  Sun Feb 12 12:20:14 GMT 2006
> 
>  Notice the timestamp is 3 minutes in the future compared with the
>  system time.  "make" is not a very happy bunny running on this kernel
>  due to every touched file being 3 minutes in the future.

I've had several spates of time-going-nuts on ppc64.  The most recent one
was because someone went and fiddled with Kconfig naming and I lost the RTC
driver.

What does `grep RTC .config' say?
