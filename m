Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282916AbRLGRgA>; Fri, 7 Dec 2001 12:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284258AbRLGRfl>; Fri, 7 Dec 2001 12:35:41 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:22543 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282916AbRLGRfh>; Fri, 7 Dec 2001 12:35:37 -0500
Message-ID: <3C10FDCF.D8E473A0@zip.com.au>
Date: Fri, 07 Dec 2001 09:35:11 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Udo A. Steinberg" <reality@delusion.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: release() locking
In-Reply-To: <3C10D83E.81261D74@delusion.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> Hi Andrew,
> 
> According to Linus' 2.5.1-pre changelog, the release locking changes
> introduced in -pre5 are your work. Those changes, however, seem to
> break the keyboard driver:
> 
> keyboard: Timeout - AT keyboard not present?(f4)
> 
> Other people (i.e. Mike Galbraith) have been experiencing the same.

wasntmeididntdoit

> Do you have an updated patch which fixes those issues? -pre6 still
> contains the same stuff as -pre5 and if it's broken then Linus should
> probably back it out.

My patch simply fixed a few things like holding spinlocks across
sleeping functions, forgetting to release locks when returning
from functions, etc.

Yes, others have suggested that the whole lot should be reverted,
for several reasons.  However it looks like that won't happen, so we
need to debug the present code.  But it works for me.

I can review the code, see if anything stands out.  But it'll probably
require someone who can reproduce it to be able to fix it.

-
