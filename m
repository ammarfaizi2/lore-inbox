Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTDYLmq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 07:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbTDYLmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 07:42:46 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:62182 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263870AbTDYLmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 07:42:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16041.8715.409998.274020@gargle.gargle.HOWL>
Date: Fri, 25 Apr 2003 13:54:51 +0200
From: mikpe@csd.uu.se
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1 on x86_64 oops at shutdown -h
In-Reply-To: <p73r87rwrri.fsf@oldwotan.suse.de>
References: <16040.16960.528537.454110@gargle.gargle.HOWL.suse.lists.linux.kernel>
	<p73r87rwrri.fsf@oldwotan.suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > mikpe@csd.uu.se writes:
 > 
 > > 2.4.21-rc1 on x86_64 oopses on me at shutdown -h in certain situations.
 > > It's repeatable. Here's the raw oops:
 > 
 > Ah I know what the problem is. I already fixed it in CVS two weeks ago, but 
 > the merge with marcelo was in the brokenness window and I forgot about
 > it because of the long delay (the patch got only applied three weeks
 > later or so)
 > 
 > Just copy arch/x86_64/lib/copy_user.S from an 2.4.20 kernel or revert the 
 > changes in  that file in 2.4.21-rc1, that should fix it.

Confirmed. 2.4.21-rc1 with copy_user.S from -pre7 doesn't oops any more.
Thanks.

/Mikael
