Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbSK1FVK>; Thu, 28 Nov 2002 00:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbSK1FVK>; Thu, 28 Nov 2002 00:21:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23969 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264856AbSK1FVJ>;
	Thu, 28 Nov 2002 00:21:09 -0500
Date: Wed, 27 Nov 2002 21:26:38 -0800 (PST)
Message-Id: <20021127.212638.35873260.davem@redhat.com>
To: sfr@canb.auug.org.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, anton@samba.org,
       ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021128162231.6935e3af.sfr@canb.auug.org.au>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
	<Pine.LNX.4.44.0211270913480.7657-100000@home.transmeta.com>
	<20021128162231.6935e3af.sfr@canb.auug.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Rothwell <sfr@canb.auug.org.au>
   Date: Thu, 28 Nov 2002 16:22:31 +1100

   On Wed, 27 Nov 2002 09:18:06 -0800 (PST) Linus Torvalds <torvalds@transmeta.com> wrote:
   > May I just suggest doing a
   > 
   > 	kernel/compat32.c
   
   OK, new version.

Well, actually I disagree with this.

I envisioned moving the compat stuff right next to the "normal"
implementation.

A problem currently, is that when people change VFS stuff up one has
to pay attention to update all the compat syscall layers as well.

This often simply does not happen because the compat version is
"somewhere else" is some other file.

Now if we put the stuff next to the non-compat stuff, it likely won't
get missed.
