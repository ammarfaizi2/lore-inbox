Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266944AbTAIS2l>; Thu, 9 Jan 2003 13:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTAIS2k>; Thu, 9 Jan 2003 13:28:40 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:5826 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266944AbTAIS2j>;
	Thu, 9 Jan 2003 13:28:39 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15901.49482.873195.574421@napali.hpl.hp.com>
Date: Thu, 9 Jan 2003 10:36:58 -0800
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Grant Grundler <grundler@cup.hp.com>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
In-Reply-To: <20030109204626.A2007@jurassic.park.msu.ru>
References: <1041942820.20658.2.camel@irongate.swansea.linux.org.uk>
	<Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com>
	<20030109204626.A2007@jurassic.park.msu.ru>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 9 Jan 2003 20:46:26 +0300, Ivan Kokshaysky <ink@jurassic.park.msu.ru> said:

  Ivan> As discussed, this patch splits PCI probing into 2 phases.
  Ivan> 1. Do the full bus enumeration, collect identification info for
  Ivan> all devices, call early fixup routines. At this stage we
  Ivan> can solve two kinds of problems:
  Ivan> - turn off devices generating PCI traffic, so we'll be
  Ivan> safe in the phase 2 (USB DMA case);
  Ivan> - allow alternative probing methods for devices that
  Ivan> cannot be safely probed by generic code (powermac I/O ASIC).
  Ivan> 2. Sizing the BARs. Now it's possible to disable the device
  Ivan> being probed, which should fix ia64 case. Note that we
  Ivan> don't need to keep the device disabled when sizing ROM
  Ivan> base register, as we probe with ROM-enable bit cleared.

Sounds good (haven't tested the code yet, but it looks fine to me).

	--david
