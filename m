Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267758AbTBMDhA>; Wed, 12 Feb 2003 22:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267765AbTBMDhA>; Wed, 12 Feb 2003 22:37:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:37270 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267758AbTBMDg7>;
	Wed, 12 Feb 2003 22:36:59 -0500
Date: Wed, 12 Feb 2003 19:32:17 -0800 (PST)
Message-Id: <20030212.193217.27086083.davem@redhat.com>
To: bjorn_helgaas@hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: tg3: back-to-back register write bug workaround causes MCA
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200302121730.53701.bjorn_helgaas@hp.com>
References: <200302121730.53701.bjorn_helgaas@hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bjorn Helgaas <bjorn_helgaas@hp.com>
   Date: Wed, 12 Feb 2003 17:30:53 -0700

   The attached change to tg3 causes an MCA on an HP zx6000
   (a 2-CPU IA64 box).  This is with Marcelo's current 2.4.x BK tree
   plus the ia64 patch.  Backing out the change below makes the
   MCA go away.
   
This sounds like either a bug in your ia64's PCI chipset or
in the tigon3 device.

Which means the only viable solution is to fail to probe this
tigon3 chip on ia64 systems using the same PCI host controller
as you have.

Can you ask a ia64 PCI host controller expert if there are any
known errata in this area?
