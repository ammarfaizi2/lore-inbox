Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290659AbSBLA7l>; Mon, 11 Feb 2002 19:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290665AbSBLA7c>; Mon, 11 Feb 2002 19:59:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18566 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290659AbSBLA7Q>;
	Mon, 11 Feb 2002 19:59:16 -0500
Date: Mon, 11 Feb 2002 16:57:30 -0800 (PST)
Message-Id: <20020211.165730.59656439.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C68685F.90C3AAA4@linux-m68k.org>
In-Reply-To: <20020211205048.GA5401@krispykreme>
	<20020211.164617.39155905.davem@redhat.com>
	<3C68685F.90C3AAA4@linux-m68k.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Tue, 12 Feb 2002 01:57:03 +0100

   "David S. Miller" wrote:
   
   > I was able to blow away all of the assembler offset stuff because now
   > all the stuff assembly wants to get at is in one structure and it is
   > trivial to compute the offsets by hand.
   
   Where's the problem to compute them automatically?

It requires ugly scripts that parse assembler files if you want it to
work in a cross compilation requirement.  Check out
arch/sparc64/kernel/check_asm.sh and the "check_asm" rule in the
Makefile or the same directory in older trees to see what I mean.

