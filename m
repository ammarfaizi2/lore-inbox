Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSG2VpZ>; Mon, 29 Jul 2002 17:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318140AbSG2VpY>; Mon, 29 Jul 2002 17:45:24 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:54220 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318139AbSG2VpX>;
	Mon, 29 Jul 2002 17:45:23 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15685.47159.255792.34483@napali.hpl.hp.com>
Date: Mon, 29 Jul 2002 14:48:39 -0700
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: "'Matthew Wilcox'" <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-ia64@linuxia64.org'" <linux-ia64@linuxia64.org>
Subject: RE: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C0101F3AF@usslc-exch-4.slc.unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C0101F3AF@usslc-exch-4.slc.unisys.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 29 Jul 2002 16:29:09 -0500, "Van Maren, Kevin" <kevin.vanmaren@unisys.com> said:

  Van> Yes, but that isn't the point: unless you eliminate all rw
  Van> locks, it is conceptually possible to cause a kernel deadlock
  Van> by forcing contention on the locks you didn't remove, if the
  Van> user can force the kernel to acquire a reader lock and if
  Van> something else needs to acquire the writer lock.  Correctness
  Van> is the issue, not performance.

I agree with Kevin here.  There must be some argument as to why
readers cannot indefinitely lock out a writer.  A probabilistic
argument is fine, but just saying "contention doesn't happen"
certainly isn't good enough.

	--david
