Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbTIHJdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTIHJdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:33:12 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:6338 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262167AbTIHJdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:33:11 -0400
Date: Mon, 8 Sep 2003 11:33:00 +0200 (MEST)
Message-Id: <200309080933.h889X06U011447@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca,
       mingo@redhat.com
Subject: Re: PROBLEM: APIC on a Pentium Classic SMP, kernel 2.4.21-pre5 to 2.4.23-pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Sep 2003 18:37:48 -0400, Mathieu Desnoyers wrote:
>IRQ problems with APIC enabled on a Neptune chipset, Pentium 90 SMP.
>
>Description
>
>Since kernel 2.4.21-pre2, IRQ problems are present on my Pentium 90 SMP, wi=
>th
>APIC enabled. It works well with 2.4.20 with APIC enabled, or with newer
>kernels with "noapic" kernel option.

There were a lot of I/O-APIC & MP table parsing changes in 2.4.21
for clustered apic. Chances are something there broke on your
ancient BIOS & mobo. I can't immediately see anything obviously
broken in 2.4.21: you'll have to identify the first pre-patch where
things broke and then test or revert it piece by piece.

>On kernel 2.4.21-pre2, there is a kernel oops before this, with a
>"Dereferencing NULL pointer".

You didn't run that through ksymoops and post it, so how is anyone
supposed to be able to debug it?
