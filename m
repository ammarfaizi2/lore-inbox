Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbSJPCCl>; Tue, 15 Oct 2002 22:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSJPCCl>; Tue, 15 Oct 2002 22:02:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39339 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263313AbSJPCCk>;
	Tue, 15 Oct 2002 22:02:40 -0400
Date: Tue, 15 Oct 2002 19:00:19 -0700 (PDT)
Message-Id: <20021015.190019.41374479.davem@redhat.com>
To: weigand@immd1.informatik.uni-erlangen.de
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210160156.DAA25005@faui11.informatik.uni-erlangen.de>
References: <200210160156.DAA25005@faui11.informatik.uni-erlangen.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
   Date: Wed, 16 Oct 2002 03:56:10 +0200 (MET DST)

   +               return (u32)dentry;
   
   Um, isn't this supposed to uniquely identify the dentry?
   On a platform with 64-bit pointers there's now the theoretical
   possibility of different dentries getting the same cookie ...

That's true.

We dealt with this (trying to use a kernel pointer as a cache held by
userspace) in tcp_diag by making the actual object opaque.  It was
actually two u32's, and that way it worked independant of kernel
vs. user word size.

