Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUBYNq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 08:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUBYNq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 08:46:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:62592 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261326AbUBYNqz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 08:46:55 -0500
Date: Wed, 25 Feb 2004 08:48:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Helmut Auer <vdr@helmutauer.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Change in compiler.h causes compile errors in many applications
In-Reply-To: <403CA56E.90403@helmutauer.de>
Message-ID: <Pine.LNX.4.53.0402250844490.8103@chaos>
References: <403CA56E.90403@helmutauer.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, Helmut Auer wrote:

> Hello,
> With kernel 2.6.3 a
> #ifdef __KERNEL__
> was added at the beginning of linux/compiler.h
> That causes compile errors in severel applications, because the
> following includes were no longer done.
> Was that caused by accident ?
>
> --
> Helmut Auer, helmut@helmutauer.de

The kernel headers are to be used for compiling the kernel only!
Older distributions may have a sim-link (two) for /usr/include/linux
and /usr/include/asm. These should point to the headers used to
compile the 'C' runtime library, not the current kernel headers.

A fix is to remove these symlinks and create directories that contain
your last working headers.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


