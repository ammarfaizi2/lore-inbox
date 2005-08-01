Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVHAAyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVHAAyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVHAAvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:51:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5358 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262294AbVHAAuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:50:46 -0400
Date: Sun, 31 Jul 2005 17:49:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesus Delgado <jdelgado@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4-mm1
Message-Id: <20050731174939.43b6ed82.akpm@osdl.org>
In-Reply-To: <57861437050731173826aad36d@mail.gmail.com>
References: <20050731020552.72623ad4.akpm@osdl.org>
	<57861437050731173826aad36d@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesus Delgado <jdelgado@gmail.com> wrote:
>
>   Im try test with kernels 2.6.13-rc4 and 2.6.13-rc4-mm1, the problems
>  is the boot hang:
>    my test is different combinations the acpi=off , noacpi, pci=noirq,
>  etc.etc both have is the same error not boot.
> 
>   The only information is simple:
> 
>  ......
> 
>   Uncompressiong Linux... Ok. booting the kernel.
>  _ 
>   
>   Not more information.

You should check basic .config things such as the CPU type.

Also ensure that you have `earlyprintk=vga' on the kernel boot command line.

The only thing I can think of which would cause such an early failure is
the kexec changes.  Does 2.6.13-rc1 work OK?  It had kexec.

If 2.6.13-rc1 fails then please try these patches, against 2.6.12:

ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.12-git7.gz
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.12-git8.gz

If 2.6.12-git7 works and 2.6.12-git8 fails then we'll know where to start
looking, thanks.

