Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266141AbUHWRVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbUHWRVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUHWRTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:19:18 -0400
Received: from the-village.bc.nu ([81.2.110.252]:14482 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266183AbUHWRSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:18:20 -0400
Subject: Re: strange softdog message on 2.4.20 kernel...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Qvapul <pikpus@wp.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <412a20af1d388@wp.pl>
References: <412a20af1d388@wp.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093277771.29850.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 23 Aug 2004 17:16:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-23 at 17:51, Matthew Qvapul wrote:
> 2) /sbin/modprobe softdog soft_margin=900
> 3) grep "adg" > /dev/watchdog
> 
> SOFTDOG: WDT device closed unexpectedly.  WDT will not stop!

You closed it without indicating you meant to close it so the timer
decided the watchdog daemon had died. Thats configurable when 
building the kernel (NOWAYOUT option)

Alan

