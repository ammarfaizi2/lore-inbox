Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267185AbUBSOEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267215AbUBSOEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:04:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25473 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267185AbUBSOEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:04:22 -0500
Date: Thu, 19 Feb 2004 09:05:25 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Carlos Silva <r3pek@r3pek.homelinux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hot kernel change
In-Reply-To: <12608.62.229.71.110.1077197623.squirrel@webmail.r3pek.homelinux.org>
Message-ID: <Pine.LNX.4.53.0402190845440.30037@chaos>
References: <12608.62.229.71.110.1077197623.squirrel@webmail.r3pek.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Carlos Silva wrote:

> hi,
>
> i would like to know if isn't it possible to implement a hot kernel
> change, i mean, without reboot. i would do it myself if i had the knoledge
> to do it but i'm starting with kernel-level programing now. i think it
> would be possible if we make something like M$'s OS do when it hibernates,
> copy all the memory, registers, etc to the disc and then put all back
> again.
>
> am i dreaming or this is possible? :)
>
> Greetings,
>
> Carlos "r3pek" Silva

Sure it's possible. However, you can't change to a new kernel this
way because the addresses of the hardware devices like the PCI bus
devices may change with a new kernel. Since the displacements of
the kernel's internal workings will change with a new version, there
would need to be considerable work done in re-designing the kernel
so that it wouldn't matter.

The best you can do, right now, is reload the same kernel. It
will take about as much time as a reboot, so why bother? Oh, you
intend to keep the same processes running, do you? You expect to
be writing a letter in X-windows and hit the reset switch, magically
returning to the same state after the machine has a new kernel
installed? Well, well-written software is indistinguishable from
magic, but first you need to find out how to make time run back-
wards because, at the very least, the new kernel will be installed
in the future which means many things will have changed (like
network IP addresses, dynamic routes, remote file discriptors, etc.)
Sounds like a neat project for a College Student who wants to
learn to solve problems they haven't even dreamed of yet.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an Intel Pentium III machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


