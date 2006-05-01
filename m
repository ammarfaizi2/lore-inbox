Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWEAHXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWEAHXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 03:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWEAHXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 03:23:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3531 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751302AbWEAHXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 03:23:07 -0400
Date: Mon, 1 May 2006 00:18:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: possible cleanups
Message-Id: <20060501001803.48ac34df.akpm@osdl.org>
In-Reply-To: <20060501071134.GH3570@stusta.de>
References: <20060501071134.GH3570@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> This patch contains the following possible cleanups:

Please avoid mixing together cleanups

>  - proper prototypes for the following functions:
>    - ctrl_alt_del()  (in include/linux/reboot.h)
>    - getrusage()     (in include/linux/resource.h)
>  - make the following needlessly global functions static:
>    - kernel_restart_prepare()
>    - kernel_kexec()

which I will apply, together with API changes

>  - remove the following unused EXPORT_SYMBOL:
>    - in_egroup_p
>  - remove the following unused EXPORT_SYMBOL_GPL's:
>    - kernel_restart
>    - kernel_halt

which I will not.

We have a process for the latter.  And even if we ignore that process, the
patch ends up sitting in -mm for ages because of the API change, along with
the cleanups, which could be merged up promptly.

