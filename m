Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTI0EeN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 00:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTI0EeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 00:34:13 -0400
Received: from palrel12.hp.com ([156.153.255.237]:54682 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262108AbTI0EeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 00:34:12 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16245.4929.723220.900314@napali.hpl.hp.com>
Date: Fri, 26 Sep 2003 21:34:09 -0700
To: Andi Kleen <ak@muc.de>
Cc: "David S. Miller" <davem@redhat.com>, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <m33ceij1q7.fsf@averell.firstfloor.org>
References: <A4gy.8wi.13@gated-at.bofh.it>
	<A4gy.8wi.15@gated-at.bofh.it>
	<A4gy.8wi.17@gated-at.bofh.it>
	<A4gy.8wi.11@gated-at.bofh.it>
	<A4Tv.Ud.37@gated-at.bofh.it>
	<AepM.5Zb.41@gated-at.bofh.it>
	<m33ceij1q7.fsf@averell.firstfloor.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 27 Sep 2003 06:26:40 +0200, Andi Kleen <ak@muc.de> said:

  Andi> You handle misalignment->misalignment copies with zero or
  Andi> small cost - when both source and destination have the same
  Andi> misalignment. I guess you do that by just aligning the pointer
  Andi> at the beginning of the function. That works as long as both
  Andi> source and destination have the same misalignment.

  Andi> But that is not what happens here. The copy is a
  Andi> misaligned->aligned copy and that cannot be handled at zero
  Andi> cost (unless you have zero misalignment penalty in
  Andi> load/store). Either the load or the store in the copy loop
  Andi> will be always misaligned, no matter what tricks you play. You
  Andi> cannot avoid this by aligning the pointers.

Geez, Andi, get a clue.  You've been working with x86 for too long.

You really can't imagine that you could combine two source words into
a single destination word?  Look ma, no unaligned accesses...

	--david
