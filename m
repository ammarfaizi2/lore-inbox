Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269476AbUIZCNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269476AbUIZCNg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 22:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269485AbUIZCNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 22:13:36 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:52128 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S269476AbUIZCNd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 22:13:33 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make make install install modules too
Date: Sat, 25 Sep 2004 22:13:32 -0400
User-Agent: KMail/1.7
Cc: Matthew Wilcox <matthew@wil.cx>, Matthew Wilcox <willy@debian.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>
References: <20040917170051.GU642@parcelfarce.linux.theplanet.co.uk> <200409171338.51924.gene.heskett@verizon.net> <20040926013300.GL16153@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040926013300.GL16153@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409252213.32217.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.50.119] at Sat, 25 Sep 2004 21:13:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 September 2004 21:33, Matthew Wilcox wrote:
>On Fri, Sep 17, 2004 at 01:38:51PM -0400, Gene Heskett wrote:
>> This is not a good patch IMO.  Many of us do things with scripts
>> to drive the compile process, either in the name of repeatability
>> or consistency.   These scripts may step out of the src tree and
>> go make something else (lm_sensors comes to mind when it wasn't
>> part of the kernel) whose output goes into the
>> /lib/modules/version/ directory so that by the time the make
>> modules_install runs, everything is already in place for the
>> automatic depmod the modules_install does.  We *could* work around
>> it by re-adding the depmod lines to our scripts, but it seems that
>> might be called a kludge too.
>
>Documentation/kbuild/modules.txt answers how to do this "right".  In
> any case, there's nothing to stop you changing your scripts from
> "make install && do_my_special_thing && make modules_install" to
>"make kernel_install && do_my_special_thing && make modules_install"

Entirely true.  But in the interest of doing it consistently AND my 
way, I have never used the make kernel install feature, doing my own 
copying, renameing etc.  And my own grub.conf editing too.

In my case (and I'm an old (70ish) fart getting stuck in my ways) I 
simply haven't needed to fix what isn't broken until such time as it 
actually does break.   It isn't broken, yet..  :-)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
