Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131367AbQLLBod>; Mon, 11 Dec 2000 20:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131444AbQLLBoY>; Mon, 11 Dec 2000 20:44:24 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:34714 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131367AbQLLBoJ>; Mon, 11 Dec 2000 20:44:09 -0500
Message-ID: <3A357BC4.AC568471@haque.net>
Date: Mon, 11 Dec 2000 20:13:40 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: linux-2.4.0-test12pre8/include/linux/module.h breaks sysklogd 
 compilation
In-Reply-To: <20001211145901.A8047@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wasn't there discussion that user space apps shouldn't include kernel
headers?

"Adam J. Richter" wrote:
> 
>         linux-2.4.0test12pre8/include/linux/module.h contains some
> kernel-specific declarations that now reference struct list_head, which
> which is only defined when __KERNEL__ is set.  This causes sysklogd
> and probably any other user level program that needs to include
> <linux/module.h> to fail to compile.
> 
>         The following patch brackets the (unused) offending declarations
> in #ifdef __KERNEL__...#endif.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
