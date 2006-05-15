Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWEOPMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWEOPMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWEOPMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:12:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58830 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964967AbWEOPMu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:12:50 -0400
Subject: Re: 2.6.15-rc1: IDE: fix potential data corruption with SL82C105
	interfaces
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <446890F0.3020408@ru.mvista.com>
References: <20051112165548.GB28987@flint.arm.linux.org.uk>
	 <1131818615.18258.6.camel@localhost.localdomain>
	 <446890F0.3020408@ru.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 16:25:16 +0100
Message-Id: <1147706716.26686.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 18:32 +0400, Sergei Shtylyov wrote:
>     Heh, this driver also tries to cache the single PCI register per-channel 
> like hpt366.c... This buglet concerns using fast PIO timings and is probably 
> harmless though but needs to be fixed -- I'll send a patch soon...
>     I wonder what is otherwise wrong with using 2 channels concurrently?

I've not got any dual channel devices to test, and in fact I couldn't
find anyone with dual channel stuff at all. The caching is one bug, the
fact the reset hits both channels is the other I know about.

Otherwise the libata driver is fairly similar although the timing is
pre-computed from the documentation for the DMA modes.

Alan
