Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVCQTM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVCQTM0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 14:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVCQTM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 14:12:26 -0500
Received: from alog0335.analogic.com ([208.224.222.111]:669 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261190AbVCQTMX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 14:12:23 -0500
Date: Thu, 17 Mar 2005 14:08:13 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Peter W. Morreale" <peter_w_morreale@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel memory limits?
In-Reply-To: <BAY101-F3858D9AE9F3222CAB9AB3CC1490@phx.gbl>
Message-ID: <Pine.LNX.4.61.0503171401030.22694@chaos.analogic.com>
References: <BAY101-F3858D9AE9F3222CAB9AB3CC1490@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005, Peter W. Morreale wrote:

> (I did not see this addressed in the FAQs...)
>
> How much physical memory can the 2.4.26 kernel address in kernel context on 
> x86?
>

All of it.

> What about DMA memory?
>

All of it, too. The old DMA controller(s) could only address 16 MB
because that's all the page-registers allowed. Bus-mastering DMA
off the PCI/Bus has no such limitation. Most have DMA controllers
that use scatter-lists so RAM doesn't even have to be contiguous,
only properly allocated (in pages) and nailed down with no caching.

> Local rumor says ~1GB.  But this makes little sense given a 32-bit address.
>

If you are looking for a dynamic buffer in DMA-able RAM, you probably
can only use aout 1GB, but that's not how to do DMA.

> Where in the source can I learn more about this?
>

../linux-`uname -r`/mm

> Thanks,
> -PWM

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
