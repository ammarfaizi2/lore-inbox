Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSEUFYt>; Tue, 21 May 2002 01:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316521AbSEUFYs>; Tue, 21 May 2002 01:24:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62661 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316519AbSEUFYr>;
	Tue, 21 May 2002 01:24:47 -0400
Date: Mon, 20 May 2002 22:10:55 -0700 (PDT)
Message-Id: <20020520.221055.106159485.davem@redhat.com>
To: torvalds@transmeta.com
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.16
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205202143010.949-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Mon, 20 May 2002 22:10:31 -0700 (PDT)
   
   I tried to make the interface fairly generic, so that people could easily
   do any (or none, like on x86) of these optimizations with little or no
   overhead.

It still needs to handle the "unmapping entire address space"
vs. "unmapping munmap-like operation".  Currently we'll flush
excessively when doing exit_mmap().

I'll go and hack this into your new stuff.

I guess you didn't read my emails from today for some reason,
I explained all of this.
