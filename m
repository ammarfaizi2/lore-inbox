Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVE0Hpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVE0Hpz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVE0HbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:31:07 -0400
Received: from aun.it.uu.se ([130.238.12.36]:59093 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261920AbVE0HZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:25:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17046.52070.257018.186057@alkaid.it.uu.se>
Date: Fri, 27 May 2005 09:25:26 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: <cutaway@bellsouth.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 387 emulator hack - mutant AAD trick - any objections?
In-Reply-To: <000701c5628b$583f8060$2800000a@pc365dualp2>
References: <000701c5628b$583f8060$2800000a@pc365dualp2>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cutaway@bellsouth.net writes:
 > Will there be any objections to using a quasi-documented mutation of the
 > x86's AAD instruction in the 387 emulator? Every CPU around has to do this
 > mutation correctly or a LOT of existing code will break...
 > 
 > The performance of storing to user space of BCD numbers in the 387 emulator
 > code could be improved significantly by using the mutant AAD instruction
 > trick (i.e. alter its implicit base from 10 to 16).  See reg_ld_str.c, in
 > function FPU_store_bcd()

What do you mean by "quasi-documented" and "mutant"?
Intel certainly documents the "D5 ib" form as being a
valid way to change the base from the default 10.

The only issue AFAIK is that assemblers may only
recognise the plain base-10 AAD syntax. No biggie.

/Mikael
