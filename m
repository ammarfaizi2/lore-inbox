Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUBRHbT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 02:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUBRHbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 02:31:19 -0500
Received: from data.idl.com.au ([203.32.82.9]:23972 "EHLO smtp.idl.net.au")
	by vger.kernel.org with ESMTP id S263618AbUBRHbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 02:31:18 -0500
From: Athol Mullen <athol_SPIT_SPAM@idl.net.au>
Subject: Re: (was Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three())
Newsgroups: linux.kernel
References: <1ovjW-1Ol-7@gated-at.bofh.it>
Organization: Mullen Automotive Engineering
Date: Wed, 18 Feb 2004 18:26:38 +1100
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402181826.38042.athol_SPIT_SPAM@idl.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:

> Athol, does this patch solves your problem?

> [PATCH] add 80-wires cable detection quirk for QUANTUM FIREBALLlct20 30

My apologies for the delay.  Paid work gets in the way sometimes...

I haven't had a chance to test the patch yet, but have confirmed that it is 
definately a drive-related problem.  I put it on my ICH4 as slave to another 
drive that passes the validation bit, then put the Quantum back on the ICH5 
and put the other drive in as slave.  The other drive always passes the 
validation bit and the Quantum always fails.

Another suggestion would be to make a kernel parameter such as ide0=ivb or 
hda=ivb to force ignoring the validation bit...  That way, we don't need a 
list of drive models hardcoded into the kernel.

I'll test the patch ASAP.

-- 
Athol
<http://cust.idl.com.au/athol>
Linux Registered User # 254000
I'm a Libran Engineer. I don't argue, I discuss.


