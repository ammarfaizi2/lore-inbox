Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267859AbUHZL2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267859AbUHZL2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268786AbUHZLTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:19:19 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:12161 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268791AbUHZLQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:16:32 -0400
To: Spam <spam@tnonline.net>
Cc: Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	<20040825152805.45a1ce64.akpm@osdl.org>
	<112698263.20040826005146@tnonline.net>
	<Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
	<1453698131.20040826011935@tnonline.net>
	<20040825163225.4441cfdd.akpm@osdl.org>
	<20040825233739.GP10907@legion.cup.hp.com>
	<20040825234629.GF2612@wiggy.net>
	<1939276887.20040826114028@tnonline.net>
	<20040826024956.08b66b46.akpm@osdl.org>
	<839984491.20040826122025@tnonline.net>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 26 Aug 2004 13:16:31 +0200
In-Reply-To: <839984491.20040826122025@tnonline.net>
Message-ID: <m3llg2m9o0.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> writes:

>   Keeping stuff in the kernel should make the new features
>   transparent to the applications.

No, it will make just one special case, rename within the same
filesystem, work.  (Well, two special cases, rm will also delete
the other forks). 

Unless we add a new copy(2) syscall (which would be nice for other
reasons) all applicatons that copy files will fail to copy the
streams.  So no working cp command, no nautilus nor konqueror without
changes to the application.  And if you have to change the
applications anyway, isn't it much better to agree on a shared library
in userspace that everyone uses?  Which has the added bonus that it
can be made to work on top of Linux, Windows, Ultrix and VMS?

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
