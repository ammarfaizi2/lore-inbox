Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbVIZPuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbVIZPuC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 11:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbVIZPuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 11:50:02 -0400
Received: from webmailv3.ispgateway.de ([62.67.200.115]:22449 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751643AbVIZPuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 11:50:00 -0400
Message-ID: <1127749798.433818a676435@domainfactory-webmail.de>
Date: Mon, 26 Sep 2005 17:49:58 +0200
From: Clemens Ladisch <clemens@ladisch.de>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Enable HPET on VIA8237 southbridge
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.238.46.206
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Wiese wrote:
> if you have that chip on your mainboard and want to play with it's
> hpet, this might get you going.

I'm using similar code for my ICH5 southbridge, but I patched
arch/i386/kernel/acpi/boot.c instead so that the kernel can use it
for its own purposes.

> One exception: Timer1 says it can do PERIODIC mode,
> but this doesn't work here. One shot is ok.

This may be because your patch doesn't initialize the interrupt
routing registers (which would have been the BIOS' job).


Regards,
Clemens

