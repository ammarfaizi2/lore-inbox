Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbTJCNMm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 09:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbTJCNMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 09:12:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23427 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263740AbTJCNMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 09:12:40 -0400
Date: Fri, 3 Oct 2003 09:14:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Emmanuel Fleury <fleury@cs.auc.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Floppy disk working constantly
In-Reply-To: <1065186072.6517.44.camel@rade7.s.cs.auc.dk>
Message-ID: <Pine.LNX.4.53.0310030909040.12482@chaos>
References: <1065186072.6517.44.camel@rade7.s.cs.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Oct 2003, Emmanuel Fleury wrote:

> Hi,
>
> I am testing the 2.6.0-test6 and I noticed that my floppy driver is
> working constantly.
>
> More details:
>
> I have compiled the floppy driver as a module:
> CONFIG_BLK_DEV_FD=m
>
> I noticed that the floppy drive was constantly on and when a disk was in
> it was acting as it was reading (but no request to do so was sent).
>
> Then I noticed that the module was not loaded, so I did a "modprobe
> floppy" and instantly the floppy driver shot down and act normally...
>
> I guess that this problem has been already reported, but I didn't manage
> to find it in the mailing-list archive, so I am submitting it in doubt.
>
[SNIPPED...]

What are you using as a boot loader? This may be a problem with
the boot loader not turning off the floppy drive motor before
it transfers control to Linux. With no built-in floppy driver,
the motor would never turn off. With quick boot hard-disks,
the floppy motor may still be ON from the initial BIOS access.

Just for kicks, change the order of boot devices in your
BIOS so that the floppy is never accessed during boot. This
should verify the problem.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


