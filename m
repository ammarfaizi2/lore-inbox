Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWF2PQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWF2PQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWF2PQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:16:47 -0400
Received: from mailhost.tue.nl ([131.155.3.8]:33240 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S1750782AbWF2PQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:16:45 -0400
Message-ID: <44A3EEDC.30006@etpmod.phys.tue.nl>
Date: Thu, 29 Jun 2006 17:16:44 +0200
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from	Longhaul
 by rw semaphores
References: <44A2C9A7.6060703@interia.pl> <1151581077.23785.9.camel@localhost.localdomain> <44A3C17F.3060204@etpmod.phys.tue.nl> <44A3DFDB.7050202@interia.pl>
In-Reply-To: <44A3DFDB.7050202@interia.pl>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafa³ Bilski wrote:
>> If I understand correctly, trouble occurs when the processor tries to
>> snoop? Would disabling (via MSR) and flushing the caches before changing
>> the frequency help in that case?
>>
>> Groeten,
>> Bart
>>
> 
> CPU is VIA C3 in EBGA "Nehemiah" core 6.9.8.
> I'm using flush_cache_all(). Is there anything more powerfull?
> I'm using MSR_VIA_FCR.
> I can disable L2 cache (or at least I think so) - this doesn't help.
> I can't disable L1 cache - processor stops when I'm trying to set 
> I-cache or D-cache disable bit.

Maybe you need to do something with the cache bits in CR0 as well. It
could be something like that. Hardware can be stuborn. I remember the
old Winchips (C3 predecessors) hanging when trying to disable caching of
plain ram via MCR's for instance.

-- 
Bart Hartgers - TUE Eindhoven - http://plasimo.phys.tue.nl/bart/contact/
