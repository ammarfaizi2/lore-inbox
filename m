Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270171AbRIBXKM>; Sun, 2 Sep 2001 19:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270206AbRIBXKC>; Sun, 2 Sep 2001 19:10:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24710 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270171AbRIBXJv>;
	Sun, 2 Sep 2001 19:09:51 -0400
Date: Sun, 02 Sep 2001 16:08:59 -0700 (PDT)
Message-Id: <20010902.160859.104033892.davem@redhat.com>
To: Richard.Zidlicky@stud.informatik.uni-erlangen.de
Cc: thunder7@xs4all.nl, parisc-linux@lists.parisc-linux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs
 on parisc architecture
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010903003437.A385@linux-m68k.org>
In-Reply-To: <20010902150023.U5126@parcelfarce.linux.theplanet.co.uk>
	<20010902195717.A21209@middle.of.nowhere>
	<20010903003437.A385@linux-m68k.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>
   Date: Mon, 3 Sep 2001 00:34:37 +0200

   On Sun, Sep 02, 2001 at 07:57:17PM +0200, thunder7@xs4all.nl wrote:
   >  /* 64 bit systems (and the S/390) need to be aligned explicitly -jdm */
   > -#if BITS_PER_LONG == 64 || defined(__s390__)
   > +#if BITS_PER_LONG == 64 || defined(__s390__) || defined(__hppa__)
   >  #   define ADDR_UNALIGNED_BITS  (3)
   >  #endif
   
   couldn't reiserfs use asm/unaligned.h like anyone else?
   Seems at least sparc and mips may need the same treatment.

Sparc will act correctly for unaliagned accesses.

It will trap and run very slowly, but it wont' OOPS and
it will give correct results.

This is actually required behavior, I don't know why parisc
is acting differently.

Later,
David S. Miller
davem@redhat.com
