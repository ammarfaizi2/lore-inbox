Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280920AbRKCBph>; Fri, 2 Nov 2001 20:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280921AbRKCBpR>; Fri, 2 Nov 2001 20:45:17 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:63237 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280920AbRKCBpK>; Fri, 2 Nov 2001 20:45:10 -0500
Message-ID: <3BE34AFA.B74AA7CF@zip.com.au>
Date: Fri, 02 Nov 2001 17:40:10 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 for pre7 ?
In-Reply-To: <20011103013632.A2427@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> 
> Hi.
> 
> I have tried to adapt the ext3 patch for pre6 to pre7, but many things
> in the buffer and cache sections (vmscan.c and so on) have changed...
> I also saw in CVS that there have been changes to make it work on pre7.
> But I did not guess how to make a patch from CVS.
> 
> Anyone out there has it ?

http://www.zip.com.au/~akpm/x.patch.gz

> BTW: I see there are a bunch of chages in ext3 patch outside its own
> fs subtree (try_to_free_pages and so on). Why are not integrated in
> mainline ?

These changes are needed to support the ordering requirements
of ext3, and probably any other fs which performs data journalling.
They are not needed by any fs which is currently in the tree.
