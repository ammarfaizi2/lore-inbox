Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268026AbUI1RIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268026AbUI1RIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 13:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUI1RIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 13:08:42 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:44294 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S268026AbUI1RIi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 13:08:38 -0400
Date: Tue, 28 Sep 2004 18:08:37 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Joerg Sommrey <jo175@sommrey.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: nmi watchdog failure on dual Athlon box
In-Reply-To: <20040928163324.GA5759@sommrey.de>
Message-ID: <Pine.LNX.4.58L.0409281802270.32231@blysk.ds.pg.gda.pl>
References: <20040928163324.GA5759@sommrey.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004, Joerg Sommrey wrote:

> just tried Ingo's "lockupcli" nmi watchdog test - it fails to unlock the
> box.
> 
> boot-parm:
> ...nmi_watchdog=2...

 The local APIC NMI watchdog has limited capabilities.  It may fail to 
trigger for certain lockups because there is no available event that would 
happen periodically regardless of the CPU state.  I can only suspect what 
"lockupcli" does (where is it available from, anyway?), but if it runs 
"cli; hlt", then the watchdog *will* fail.

> nmi_watchdog=1 has never worked for me (except 2.6.3-mm4).

 Too bad.  The I/O APIC watchdog triggers regardless of the CPU state and
works as long as the chipset is operational.

  Maciej
