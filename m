Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266330AbUAVSiT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbUAVSiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:38:19 -0500
Received: from aun.it.uu.se ([130.238.12.36]:59891 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266330AbUAVSh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:37:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16400.6262.97863.651276@alkaid.it.uu.se>
Date: Thu, 22 Jan 2004 19:37:42 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Karol Kozimor" <sziwan@hell.org.pl>,
       "Georg C. F. Greve" <greve@gnu.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Martin Loschwitz" <madkiss@madkiss.org>,
       <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>,
       <acpi-devel@lists.sourceforge.net>
Subject: RE: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6082D0B8@scsmsx403.sc.intel.com>
References: <88056F38E9E48644A0F562A38C64FB6082D0B8@scsmsx403.sc.intel.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh writes:
 > 
 > This was how the APIC_TIMER_BASE_DIV was originally added there.
 > http://www.ussg.iu.edu/hypermail/linux/kernel/9907.1/0608.html

That message confirms my suspicion. The bits were apparently needed
in the ancient discrete LAPICs, but they clearly must not be set
in some current integrated LAPICs.

To handle both cases the code should do one of those "is intergrated"
tests we alreay have several of in apic.c. I can fix that, but not
until tomorrow.

/Mikael
