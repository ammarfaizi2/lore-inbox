Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTFHNYc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 09:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTFHNYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 09:24:32 -0400
Received: from hera.cwi.nl ([192.16.191.8]:20431 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261797AbTFHNYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 09:24:31 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 8 Jun 2003 15:38:04 +0200 (MEST)
Message-Id: <UTC200306081338.h58Dc4X28137.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: Is sys_sysfs used?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Patrick Mochel <mochel@osdl.org>

    I see that only one architecture defines __NR_sysfs: x86-64, though it
    appears most architectures mention it in arch/*/kernel/entry.S (or 
    equivalent).

There are definitions in include/asm-*/unistd.h.

    Is it used anymore? Would it be possible to remove it? 

There should be a good reason to change the kernel API.
Just "why not remove this probably unused call?" is not a good reason.

(It indeed is almost unused. A grep on a random source tree shows
a use in mount.c in busybox.)

Andries
