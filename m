Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUCEVso (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbUCEVso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:48:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:53379 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261187AbUCEVsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:48:39 -0500
Date: Fri, 5 Mar 2004 16:51:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stuart_Hayes@Dell.com
cc: linux-kernel@vger.kernel.org, andrew.grover@intel.com
Subject: Re: ACPI stack overflow
In-Reply-To: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA1@ausx2kmpc106.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.53.0403051638001.398@chaos>
References: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA1@ausx2kmpc106.aus.amer.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004 Stuart_Hayes@Dell.com wrote:

>
> Hello...
>
> I think I am getting a stack overflow when Linux is parsing the ACPI
> tables (initializing all the devices and running all the _STA methods).
> I am using the x86_64 architecture.  I would like to try increasing the
> kernel stack size, but I'm not sure how to go about doing this.
> Could someone tell me how to increase the kernel stack size?
> (And, has anyone else seen a problem with stack overflows with ACPI?)
>

Please fix your mailer. In Unix/Linux, we put in a [Enter] ('\n')
every once in awhile, usually every 79 charcters so that a line
of text does not exceed 80 characters. We do not let some indefinite
screen "auto-wrap".

> Thanks!
> Stuart
> stuart_hayes@dell.com

There have been continual changes over the years to reduce the
amount of kernel stack that the kernel uses because kernel stack-
space is "expensive". It needs to be changed in pages.  I think
that if you have a stack-overflow, then you are writing poor
kernel code. In the kernel, do not put arrays on the stack, i.e,
in "local" space. Use kmalloc()/kfree() instead.

Basically, do not increase the stack size. It just masks problems.
It does not make them go away. If you need more stack, you
are doing something wrong.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


