Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261457AbTCOPAJ>; Sat, 15 Mar 2003 10:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbTCOPAJ>; Sat, 15 Mar 2003 10:00:09 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:43273 "EHLO
	doughboy.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S261457AbTCOPAI>; Sat, 15 Mar 2003 10:00:08 -0500
Message-ID: <3E734518.6000808@snapgear.com>
Date: Sun, 16 Mar 2003 01:22:00 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Please revert second addition of stddef.h to list.h
References: <20030311211700.GI16414@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030311211700.GI16414@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mathew,

Matthew Wilcox wrote:
> I read these things on the web so I dunno how to specify a BK command
> to do what needs to be done, but this cset:
> 
> http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-1.1137.txt
> 
> is obviously wrong.

Yes, although the original patch itself was correct.
Obviously 2 patch sets that are trying to do the same
thing have been applied post 2.5.64.

Patch below would fix this...

Regards
Greg



--- linux-2.5.64-bk8/include/linux/list.h.org   Sat Mar 15 22:45:47 2003
+++ linux-2.5.64-bk8/include/linux/list.h       Sat Mar 15 22:45:53 2003
@@ -5,7 +5,6 @@

  #include <linux/stddef.h>
  #include <linux/prefetch.h>
-#include <linux/stddef.h>
  #include <asm/system.h>

  /*

------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

