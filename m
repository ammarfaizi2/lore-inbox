Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSFDSQ5>; Tue, 4 Jun 2002 14:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSFDSQ4>; Tue, 4 Jun 2002 14:16:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50086 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315372AbSFDSQz>;
	Tue, 4 Jun 2002 14:16:55 -0400
Date: Tue, 04 Jun 2002 11:13:37 -0700 (PDT)
Message-Id: <20020604.111337.51699424.davem@redhat.com>
To: mochel@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0206040821100.654-100000@geena.pdx.osdl.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick Mochel <mochel@osdl.org>
   Date: Tue, 4 Jun 2002 08:50:11 -0700 (PDT)

   On Sun, 2 Jun 2002, David S. Miller wrote:
   
   > It's happening on every platform.  It should be done before
   > arch_initcalls actually, but after core_initcalls.  I would suggest to
   > rename unused_initcall into postcore_iniscall, then use it for this
   > and sys_bus_init which has the same problem.
   
   Can't it go the other way? Instead of mass-promotion of the setup 
   functions, can't we demote the ones that are causing the problems? 
   
There's this middle area between core and subsys, why not
just be explicit about it's existence?

Short of making the true dependencies describable, I think my
postcore_initcall solution is fine.
