Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbUBZTQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbUBZTQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:16:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12161 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262946AbUBZTQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:16:01 -0500
Date: Thu, 26 Feb 2004 14:18:31 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jim Deas <jdeas0648@jadsystems.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel disables interrupts
In-Reply-To: <200402261025.AA3240886544@jadsystems.com>
Message-ID: <Pine.LNX.4.53.0402261415160.4239@chaos>
References: <200402261025.AA3240886544@jadsystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Jim Deas wrote:

> I am trouble shooting a new driver and have found a new
> kernel item that makes trouble shooting a bit harder.
> When I unload my test driver and before I can reload it
> (reseting the interrut controls)the Kernerl disables
> the chattering interrupt.
> Once the kernel has disable a spurious interrupt is there
> a way to get it back?
>
> JD

Linux version 2.4.24 doesn't "disable" a spurious interrupt!
When you unload the driver, you deallocate the interrupt you
are using (I sure hope so). When you load the driver again,
you reallocate the interrupt. If you FAILED to release the
IRQ when you unloaded the module, guess what? It's still
allocated and you can't have it anymore. That's probably
what's happening.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


