Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbSK1F2U>; Thu, 28 Nov 2002 00:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbSK1F2T>; Thu, 28 Nov 2002 00:28:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38561 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265197AbSK1F2T>;
	Thu, 28 Nov 2002 00:28:19 -0500
Date: Wed, 27 Nov 2002 21:34:01 -0800 (PST)
Message-Id: <20021127.213401.52904164.davem@redhat.com>
To: torvalds@transmeta.com
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, anton@samba.org,
       ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0211271039350.15032-100000@home.transmeta.com>
References: <20021126.235810.22015752.davem@redhat.com>
	<Pine.LNX.4.44.0211271039350.15032-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Wed, 27 Nov 2002 10:51:54 -0800 (PST)
   
   You might as well also discuss just dropping the "32" from "compat32"  
   while you're at it. As far as I can tell the code and the fundamental
   issue has nothing to do with 32-bitness per se.

I'm fine with this.

But having one "compat" could have some unintended side effects.  For
example, what if we wanted to make the iBCS2 layer work for x86 apps
on ia64?  With one "compat" thing, something like that gets hokey and
ibcs2 will probably end up in it's own tons_of_ibcs2_junk.c file.
With more care, it could be easy to integrate and simpler to maintain.

