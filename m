Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289119AbSAGFPT>; Mon, 7 Jan 2002 00:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289120AbSAGFPJ>; Mon, 7 Jan 2002 00:15:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13720 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289119AbSAGFO5>;
	Mon, 7 Jan 2002 00:14:57 -0500
Date: Sun, 06 Jan 2002 21:13:52 -0800 (PST)
Message-Id: <20020106.211352.41877178.davem@redhat.com>
To: anton@samba.org
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: results: Remove 8 bytes from struct page on 64bit archs
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020107012555.GA6623@krispykreme>
In-Reply-To: <20020106.060824.106263786.davem@redhat.com>
	<Pine.LNX.4.33.0201061542450.3859-100000@Appserv.suse.de>
	<20020107012555.GA6623@krispykreme>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Mon, 7 Jan 2002 12:25:55 +1100
   
   Perhaps the compiler should be optimising this better (can we replace
   the divide?)

As mentioned the PPC backend of gcc thinks that divides are cheaper
than multiplies.  On sparc64 for example we get multiplies by a
constant when emitting constant divides.

If you can make the struct a power of two as well as smaller, that
would eliminate both problems here but not fix the apparent bug in the
PPC backend.
