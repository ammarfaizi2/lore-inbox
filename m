Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUFACLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUFACLw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 22:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbUFACLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 22:11:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18050 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264860AbUFACLn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 22:11:43 -0400
Date: Mon, 31 May 2004 22:11:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: ndiamond@despammed.com
cc: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
In-Reply-To: <200405310152.i4V1qNk03732@mailout.despammed.com>
Message-ID: <Pine.LNX.4.53.0405312201450.7675@chaos>
References: <200405310152.i4V1qNk03732@mailout.despammed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2004 ndiamond@despammed.com wrote:

> A driver, implemented as a module, must do some floating-point
> computations including trig functions.  Fortunately the architecture
> is x86.  A few hundred kilograms of searching (almost a ton of searching :-) seems to reveal the following possibilities.
>

Since you are using one of those Windows mailers and didn't enter a
single end-of-line character, I detect that this is probably one
of those trolls. Nevertheless, the use of floating-point is forbidden
within the kernel. Period. Because anybody who thinks they need
floating-point mathematics within the kernel is completely without
a clue, the floating-point context is not saved/restored during system
calls.

You must pair a user-mode program (usually called a daemon) with
the kernel-mode interface to your hardware (your module). This
combination will provide whatever functionality you require. The
user-mode daemon does the math and probably a lot of other things
as well.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5583.66 BogoMips).
            Note 96.31% of all statistics are fiction.


