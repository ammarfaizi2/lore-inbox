Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbTAXUyf>; Fri, 24 Jan 2003 15:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbTAXUyf>; Fri, 24 Jan 2003 15:54:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39660 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265689AbTAXUye>;
	Fri, 24 Jan 2003 15:54:34 -0500
Date: Fri, 24 Jan 2003 12:51:21 -0800 (PST)
Message-Id: <20030124.125121.78932406.davem@redhat.com>
To: Jeff.Wiedemeier@hp.com
Cc: jgarzik@pobox.com, ink@jurassic.park.msu.ru, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030124154635.A4161@dsnt25.mro.cpqcorp.net>
References: <20030124152453.A4081@dsnt25.mro.cpqcorp.net>
	<20030124203402.GA4975@gtf.org>
	<20030124154635.A4161@dsnt25.mro.cpqcorp.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
   Date: Fri, 24 Jan 2003 15:46:35 -0500

   On Fri, Jan 24, 2003 at 03:34:02PM -0500, Jeff Garzik wrote:
   > AFAICS, this is a per-driver decision, and needs to be done at the
   > driver level, in the tg3 driver source.
   
   The last sentence in the quote above indicates that it is not intended
   (by the PCI spec) to be a per-driver decision, but rather a system
   decision. The messages used are also a per-bus system resource and how
   an MSI goes from the PCI bus to the rest of the system (i.e. the CPU(s))
   is implementation dependent.

Yes, this is understood.

But the tg3 hw designers have decided to do something which makes this
not possible.

So, for tg3's case, it has to become a driver specific decision
whether to support MSI or not.
