Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316794AbSFDV0X>; Tue, 4 Jun 2002 17:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316797AbSFDV0W>; Tue, 4 Jun 2002 17:26:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42369 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316794AbSFDV0V>;
	Tue, 4 Jun 2002 17:26:21 -0400
Date: Tue, 04 Jun 2002 14:23:12 -0700 (PDT)
Message-Id: <20020604.142312.23013040.davem@redhat.com>
To: mochel@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0206041413530.654-100000@geena.pdx.osdl.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick Mochel <mochel@osdl.org>
   Date: Tue, 4 Jun 2002 14:14:26 -0700 (PDT)

   On Tue, 4 Jun 2002, David S. Miller wrote:
   
   > Does sys_bus_init require the generic bus layer to be initialized
   > first?
   
   Yes, and it is in drivers/base/bus.c just before sys_bus_init is called.

Linkers are allowed to reorder object files unless you tell them
explicitly not to.

This is why you need to put this stuff into a seperate initcall level.
This is precisely why I suggest postcore_initcall as the fix.
