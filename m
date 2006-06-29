Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWF2MDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWF2MDX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbWF2MDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:03:23 -0400
Received: from mailhost.tue.nl ([131.155.2.19]:49373 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S1751397AbWF2MDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:03:22 -0400
Message-ID: <44A3C17F.3060204@etpmod.phys.tue.nl>
Date: Thu, 29 Jun 2006 14:03:11 +0200
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: =?UTF-8?B?UmFmYcWCIEJpbHNraQ==?= <rafalbilski@interia.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from	Longhaul
 by rw semaphores
References: <44A2C9A7.6060703@interia.pl> <1151581077.23785.9.camel@localhost.localdomain>
In-Reply-To: <1151581077.23785.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Mer, 2006-06-28 am 20:25 +0200, ysgrifennodd Rafał Bilski:
>> AUTOHALT, this means interrupts must be disabled except for the time tick, 
>> which should be reset to >=1ms. Care must be taken to avoid other system events 
>> that could interfere with this operation. A few examples are snooping, NMI, 
>> INIT, SMI and FLUSH."
> 
> "snooping". So we do need the cache sorting out.
>

If I understand correctly, trouble occurs when the processor tries to
snoop? Would disabling (via MSR) and flushing the caches before changing
the frequency help in that case?

Groeten,
Bart

-- 
Bart Hartgers - TUE Eindhoven - http://plasimo.phys.tue.nl/bart/contact/
