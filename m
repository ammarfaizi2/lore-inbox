Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131984AbRAaTqX>; Wed, 31 Jan 2001 14:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132205AbRAaTqN>; Wed, 31 Jan 2001 14:46:13 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:30743 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131984AbRAaTqG>; Wed, 31 Jan 2001 14:46:06 -0500
Message-ID: <3A786B1C.F6A3CE83@sgi.com>
Date: Wed, 31 Jan 2001 11:44:28 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Power usage Q and parallel make question (separate issues)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remember reading some time back that on a pentium the difference between a
pentium in HLT vs. running was about 2-3 watts vs. 15-20 watts.  Does anyone
know the difference for today's CPU's?  P-III/P-IV or other archs?

How about the difference when calling the BIOS power-save feature?  With
the threat of rolling blackouts here in CA, I was wondering what the power
consumption might be of a 100,000 or 1,000,000 CPU's in HLT vs. doing complex
mathematical computation?

Separately -- Parallel Make's
----------    ===============
So, just about anyone I know uses make -j X [-l Y] bzImage modules, but I noticed that
make modules_install isn't parallel safe in 2.4 -- since it takes much longer than the
old, it would make sense to want to run it in parallel as well, but it has a 
delete-old, <multiple sub-dirs>, index-new for deps.  Those "3" steps can't be done
in parallel safely.  Was this intentional or would a 'fix' be desired?

Is it the intention of the Makefile maintainers to allow a parallel or distributed
make?  I know for me it makes a noticable difference even on a 1 CPU machine
(CPU overlap with disk I/O), and with multi CPU machines, it's even more noticable.

Is a make of the kernel and/or the modules designed to be parallel safe?  Is it 
something I should 'rely' on?  If it isn't, should it be?

-l

-- 
Linda A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
