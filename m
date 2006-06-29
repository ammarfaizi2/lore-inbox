Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWF2ONE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWF2ONE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 10:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWF2OND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 10:13:03 -0400
Received: from smtp4.poczta.interia.pl ([80.48.65.7]:48770 "EHLO
	smtp4.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1750751AbWF2ONC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 10:13:02 -0400
Message-ID: <44A3DFDB.7050202@interia.pl>
Date: Thu, 29 Jun 2006 16:12:43 +0200
From: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060628)
MIME-Version: 1.0
To: Bart Hartgers <bart@etpmod.phys.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from	Longhaul
 by rw semaphores
References: <44A2C9A7.6060703@interia.pl> <1151581077.23785.9.camel@localhost.localdomain> <44A3C17F.3060204@etpmod.phys.tue.nl>
In-Reply-To: <44A3C17F.3060204@etpmod.phys.tue.nl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-EMID: a80a8acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I understand correctly, trouble occurs when the processor tries to
> snoop? Would disabling (via MSR) and flushing the caches before changing
> the frequency help in that case?
> 
> Groeten,
> Bart
> 

CPU is VIA C3 in EBGA "Nehemiah" core 6.9.8.
I'm using flush_cache_all(). Is there anything more powerfull?
I'm using MSR_VIA_FCR.
I can disable L2 cache (or at least I think so) - this doesn't help.
I can't disable L1 cache - processor stops when I'm trying to set 
I-cache or D-cache disable bit.

Thanks
Rafa³


----------------------------------------------------------------------
PS. Fajny portal... >>> http://link.interia.pl/f196a

