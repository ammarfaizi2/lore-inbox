Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267759AbSLTJec>; Fri, 20 Dec 2002 04:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267760AbSLTJec>; Fri, 20 Dec 2002 04:34:32 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:22509 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267759AbSLTJeb>;
	Fri, 20 Dec 2002 04:34:31 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15874.58889.846488.868570@napali.hpl.hp.com>
Date: Fri, 20 Dec 2002 01:42:33 -0800
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.x disable BAR when sizing
In-Reply-To: <atubg3$699$1@penguin.transmeta.com>
References: <20021219213712.0518B12CB2@debian.cup.hp.com>
	<atubg3$699$1@penguin.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 20 Dec 2002 05:57:23 +0000 (UTC), torvalds@transmeta.com (Linus Torvalds) said:

  Linus> DO NOT DO THIS. It locks up some machines at
  Linus> bootup. Hard. Total bus lockup if you have legacy USB enabled
  Linus> (or anything else that does DMA, for that matter) at the same
  Linus> time as probing the northbridge with this.

  Linus> Trust me.  If you have some new silly ia64-specific bug, the
  Linus> fix is _not_ to break real and existing hardware out there.

Could you please stop this ia64 paranoia and instead explain to me why
it's OK to relocate a PCI device to (0x100000000-PCI_dev_size)
temporarily?  That just seems horribly unsafe to me.  The PCI spec
seems to say the same as it says pretty clearly that memory decoding
should be disabled during BAR-sizing.  If certain bridges cause
problems, perhaps those need to be special-cased?

	--david
