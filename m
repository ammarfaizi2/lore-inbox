Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268670AbUHZLsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268670AbUHZLsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268733AbUHZLi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:38:57 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:13710 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268685AbUHZLcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:32:24 -0400
Date: Thu, 26 Aug 2004 13:35:11 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1906433242.20040826133511@tnonline.net>
To: Christer Weinigel <christer@weinigel.se>
CC: Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, <reiser@namesys.com>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <m3llg2m9o0.fsf@zoo.weinigel.se>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
 <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net>
 <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
 <1453698131.20040826011935@tnonline.net>
 <20040825163225.4441cfdd.akpm@osdl.org>
 <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net>
 <1939276887.20040826114028@tnonline.net>
 <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net>
 <m3llg2m9o0.fsf@zoo.weinigel.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Spam <spam@tnonline.net> writes:

>>   Keeping stuff in the kernel should make the new features
>>   transparent to the applications.

> No, it will make just one special case, rename within the same
> filesystem, work.  (Well, two special cases, rm will also delete
> the other forks). 

> Unless we add a new copy(2) syscall (which would be nice for other
> reasons) all applicatons that copy files will fail to copy the
> streams.

  How  so?  The whole idea is that the underlaying OS that handles the
  copying  should  also  know  to  copy  everything, otherwise you can
  implement  everything  into  applications  and  just  skip the whole
  filesystem part.

  Of  course,  it  won't  work if applications themselves are actually
  transferring  the  data  and  create the new files directly onto the
  filesystem. This just seem so wrong.

  ~S

>   So no working cp command, no nautilus nor konqueror without
> changes to the application.  And if you have to change the
> applications anyway, isn't it much better to agree on a shared library
> in userspace that everyone uses?  Which has the added bonus that it
> can be made to work on top of Linux, Windows, Ultrix and VMS?

>   /Christer





