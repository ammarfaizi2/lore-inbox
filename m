Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbSJDVIl>; Fri, 4 Oct 2002 17:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262786AbSJDVIl>; Fri, 4 Oct 2002 17:08:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47072 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262784AbSJDVIk>;
	Fri, 4 Oct 2002 17:08:40 -0400
Date: Fri, 04 Oct 2002 14:06:29 -0700 (PDT)
Message-Id: <20021004.140629.89147658.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: bidulock@openss7.org, linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1033682560.28850.32.camel@irongate.swansea.linux.org.uk>
References: <20021003153943.E22418@openss7.org>
	<1033682560.28850.32.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 03 Oct 2002 23:02:40 +0100
   
   Overwriting syscall table entries is not safe. Its not safe because
   there is no locking mechanism, and its not safe because of the pentium
   III errata.

It is also non-portable, such syscall overwriting requires knowledge
of the layout of the table on every architecture.  On some platforms
it is a list of pointers + argument count, on some 64-bit platforms
it is a list of 32-bit truncated pointers to save space.

There is simply no portable way to make changes to the system call
table, so exporting it makes zero sense.
