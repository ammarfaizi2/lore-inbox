Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310974AbSCLMqz>; Tue, 12 Mar 2002 07:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311023AbSCLMqo>; Tue, 12 Mar 2002 07:46:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17610 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310974AbSCLMqf>;
	Tue, 12 Mar 2002 07:46:35 -0500
Date: Tue, 12 Mar 2002 04:43:04 -0800 (PST)
Message-Id: <20020312.044304.130027236.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org, ak@muc.de
Subject: Re: __get_user usage in mm/slab.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0203121237070.19747-100000@serv>
In-Reply-To: <Pine.LNX.4.21.0203121237070.19747-100000@serv>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Tue, 12 Mar 2002 12:58:53 +0100 (CET)

   We have to at least insert a "set_fs(get_fs())", but IMO a separate
   interface would be better. Any opinions?

Right, it is portable if set_fs(KERNEL_DS) is done around it.

This is how most arch syscall ABI translation layers work btw.

Because this way basically must work, I would prefer it gets fixed
like this instead of creating a new interface.
