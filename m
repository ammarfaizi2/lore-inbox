Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbTLLPDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 10:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbTLLPDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 10:03:11 -0500
Received: from chaos.analogic.com ([204.178.40.224]:42113 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265251AbTLLPDD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 10:03:03 -0500
Date: Fri, 12 Dec 2003 10:04:47 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
In-Reply-To: <yw1xd6auyvac.fsf@kth.se>
Message-ID: <Pine.LNX.4.53.0312121000150.10423@chaos>
References: <16345.51504.583427.499297@l.a> <yw1xd6auyvac.fsf@kth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, [iso-8859-1] Måns Rullgård wrote:

> Dale Mellor <dale@dmellor.dabsol.co.uk> writes:
>
> > 1. Floppy motor spins when floppy module not installed.
>
> It's a known problem.  Some broken BIOSes don't turn off the motor
> after probing for a disk.  One solution is to change the boot priority
> in the BIOS settings so the hard disk is tried before floppy.  If you
> ever need to boot from a floppy, you can change it back.
>
> --
> Måns Rullgård
> mru@kth.se

It is not a broken BIOS! The BIOS timer that ticks 18.206 times
per second has an ISR that, in addition to keeping time, turns
OFF the FDC motor after two seconds of inactivity. This ISR is taken
away by Linux. Therefore Linux must turn off that motor! It is a
Linux bug, not a BIOS bug. Linux took control away from the BIOS
during boot.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


