Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261943AbSJDWXR>; Fri, 4 Oct 2002 18:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261953AbSJDWXR>; Fri, 4 Oct 2002 18:23:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32225 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261943AbSJDWXR>;
	Fri, 4 Oct 2002 18:23:17 -0400
Date: Fri, 04 Oct 2002 15:21:16 -0700 (PDT)
Message-Id: <20021004.152116.116611188.davem@redhat.com>
To: bidulock@openss7.org
Cc: alan@lxorguk.ukuu.org.uk, ak@suse.de, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021004131547.B2369@openss7.org>
References: <p73fzvmqdg4.fsf@oldwotan.suse.de>
	<1033757193.31839.51.camel@irongate.swansea.linux.org.uk>
	<20021004131547.B2369@openss7.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Brian F. G. Bidulock" <bidulock@openss7.org>
   Date: Fri, 4 Oct 2002 13:15:47 -0600
   
   Attached is an untested patch for LiS. 

The sparc64 changes are absolutely wrong, the syscalls take pointers
and thus must go through a 32-bit ABI to 64-bit ABI syscall
translation routine.

This is another reason I don't want people to be able to register
system calls dynamically, it bypasses being able to verify this for
ppc64, mips64, sparc64, x86_64 x86, and ia64 x86.
