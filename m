Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313121AbSDGL0T>; Sun, 7 Apr 2002 07:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313132AbSDGL0S>; Sun, 7 Apr 2002 07:26:18 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:45324 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313121AbSDGL0R>;
	Sun, 7 Apr 2002 07:26:17 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre6 dead Makefile entries 
In-Reply-To: Your message of "Sun, 07 Apr 2002 12:11:32 +0100."
             <20020407121132.E30048@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Apr 2002 21:26:06 +1000
Message-ID: <27869.1018178766@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2002 12:11:32 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>On Sun, Apr 07, 2002 at 09:01:39PM +1000, Keith Owens wrote:
>> lib/Makefile                    crc32.o
>
>crc32.c seems to exist in linux/lib/ in 2.5.7 and 2.5.8-pre2

But not in 2.4.19-pre6.  Given an object which has no source, it could
be dead, a typing error or a placeholder for future work.  There is no
way to tell which, most are dead entries.

I don't object to placeholder entries ("will be back ported from 2.5
one day" or "is only used in ia64") as long as they are commented out
until the source also exists.  In this case, crc32 is required for ia64
on 2.4 kernels and we have a broken merge.  The Makefile was updated
from the ia64 patch but the source was not.  In 2.5 everybody uses
crc32.  Best fix is to delete crc32 from 2.4 Makefiles and add it only
in the ia64 patch.

