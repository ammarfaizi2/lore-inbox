Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275348AbTHGOC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275349AbTHGOC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:02:27 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:24707 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275348AbTHGOCV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:02:21 -0400
Subject: Re: Loading Pentium III microcode under Linux - catch 22!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Rankin <rankincj@yahoo.com>
Cc: tigran@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030807122850.99548.qmail@web40611.mail.yahoo.com>
References: <20030807122850.99548.qmail@web40611.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060264715.3169.51.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 14:58:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 13:28, Chris Rankin wrote:
> I have modified by boot scripts to load the microcode
> as soon as the root filesystem has been successfully
> mounted. However, this means that kernel always boots
> on buggy CPUs! For example, last night my boot failed
> just after releasing the unused kernel memory. I
> suspect that the record temperatures that my part of
> the world is currently experiencing is adversely
> influencing things. My boot-ups are usually fine

As far as I am aware none of the microcode updates even apply
to 933Mhz era PIII, just the ones the BIOS ships with by default
nowdays. Also the kind of stuff the errata fix are obscure 
ultra-weird corner cases people just don't hit.

Thus I'd be very suprised if loading the microcode any earlier
was neccessary - certainly nobody else has reported needing to.

> In an ideal world, I would like Linux to load the
> microcode *before* the kernel boots, which begs the
> question of "How?". Can you suggest anything, please?

The kernel can't load the microcode until it has booted, it can
load it very early after that from initrd.

