Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTEPWln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 18:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbTEPWln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 18:41:43 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63399
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263062AbTEPWlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 18:41:42 -0400
Subject: RE: [PATCH] 2.5.68 FUTEX support should be optional
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christopher Hoover <ch@murgatroid.com>, "'Andrew Morton'" <akpm@digeo.com>,
       "'Perez-Gonzalez, Inaky'" <inaky.perez-gonzalez@intel.com>,
       hch@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305141758070.28007-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305141758070.28007-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053122141.5589.45.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 May 2003 22:55:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-15 at 02:00, Linus Torvalds wrote:
> I will strongly argue against making futexes conditional, simply because I 
> _want_ people to be able to depend on them in modern kernels. I do not 
> want developers to fall back on SysV semaphores just because it's too 
> painful for them to use the faster alternatives.

In the embedded space being able to chop stuff out makes a lot of sense.
It also encourages people to get modularity right. These are the same
people who already turn SYS5 IPC off as well, as as for glibc, well its
cute but its frequently bigger than the entire flash of the device.

There are arguments in some cases for avoiding the selections (notably
adding a zillion ifdefs to remove something thats utterly trivial) but
providing most users see only

	Remove kernel features for embedded systems (Y/N)

its no more dangerous/hassle than the kernel debug menu


