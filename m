Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTIZPl3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 11:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTIZPl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 11:41:29 -0400
Received: from palrel12.hp.com ([156.153.255.237]:53976 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262366AbTIZPl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 11:41:28 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16244.24102.608275.589856@napali.hpl.hp.com>
Date: Fri, 26 Sep 2003 08:41:26 -0700
To: Andi Kleen <ak@muc.de>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <m3ad8rinta.fsf@averell.firstfloor.org>
References: <zU7D.2Ji.27@gated-at.bofh.it>
	<m3ad8rinta.fsf@averell.firstfloor.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 26 Sep 2003 17:14:57 +0200, Andi Kleen <ak@muc.de> said:

  Andi> Manfred Spraul <manfred@colorfullife.com> writes:
  >> David wrote:

  >>> Fine, then we should have something like an rx_copybreak scheme
  >>> in the ns83820 driver too.

  >> Is that really the right solution? Add a full-packet copy to
  >> every driver?  IMHO the fastest solution would be to copy only
  >> the ip & tcp headers, and keep the rest as it is. And preferable
  >> in the network core, to avoid having to copy&paste that into
  >> every driver.

  Andi> One problem is that you still have an unaligned->aligned copy
  Andi> to user space in recvmsg (the user buffer is usually aligned
  Andi> and the network payload will be unaligned). And that will be
  Andi> very slow.

Why would that be?  Slower, yes, but very slow?

	--david
