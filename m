Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290645AbSBLAsb>; Mon, 11 Feb 2002 19:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290652AbSBLAsV>; Mon, 11 Feb 2002 19:48:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9350 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290645AbSBLAsE>;
	Mon, 11 Feb 2002 19:48:04 -0500
Date: Mon, 11 Feb 2002 16:46:17 -0800 (PST)
Message-Id: <20020211.164617.39155905.davem@redhat.com>
To: anton@samba.org
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020211205048.GA5401@krispykreme>
In-Reply-To: <3C6832CC.D9D27F2F@linux-m68k.org>
	<20020211205048.GA5401@krispykreme>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Tue, 12 Feb 2002 07:50:48 +1100
   
   On archs where we use a register to point to current I cant see why we
   need this thread_info junk. I'd be happy if we could put it all in the
   task struct for non intel.
   
I am in fact very happy with the thread_info implementation
on sparc64.

I was able to blow away all of the assembler offset stuff because now
all the stuff assembly wants to get at is in one structure and it is
trivial to compute the offsets by hand.
