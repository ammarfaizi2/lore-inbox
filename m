Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTEFOP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263773AbTEFOO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:14:57 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:42631 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263772AbTEFOOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:14:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16055.50728.288545.718296@gargle.gargle.HOWL>
Date: Tue, 6 May 2003 16:26:48 +0200
From: mikpe@csd.uu.se
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix x86_64 pte_user() and floppy.h for 2.5.69
In-Reply-To: <20030506142252.GB28449@Wotan.suse.de>
References: <16055.49364.106094.795419@gargle.gargle.HOWL>
	<20030506142252.GB28449@Wotan.suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > On Tue, May 06, 2003 at 04:04:04PM +0200, mikpe@csd.uu.se wrote:
 > > Andi,
 > > 
 > > 2.5.69 failed to link on x86_64 due to a missing reference to pte_user().
 > > I simply stole the one that i386 added in .68 -> .69.
 > > There's also irqreturn_t warnings on floppy.h -- fixed also by syncing
 > > with i386' floppy.h.
 > 
 > At least the floppy.h thing is already fixed.
 > 
 > The pte_user fix is not needed. The correct fix is to change the 
 > #ifdef mm/memory.c checks for. It's broken for most/all
 > architecture which are not i386 including x86-64. 
 > They have FIXADDR_START, but don't need this check and it's even
 > wrong to have it.

Ah, Ok.
