Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273951AbRIXPo0>; Mon, 24 Sep 2001 11:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273962AbRIXPoQ>; Mon, 24 Sep 2001 11:44:16 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:54545 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S273960AbRIXPoF>; Mon, 24 Sep 2001 11:44:05 -0400
Date: Mon, 24 Sep 2001 11:44:32 -0400
Message-Id: <200109241544.f8OFiWI05617@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
X-Newsgroups: linux.dev.kernel
In-Reply-To: <20010924013328.A29582@gondor.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010924013328.A29582@gondor.com> jan@gondor.com wrote:
| On Tue, Sep 18, 2001 at 05:51:48PM +0300, VDA wrote:
| > Since we don't have any negative feedback on Athlon bug
| > stomper, I think patch could be applied to
| > arch/i386/kernel/pci-pc.c in mainline kernel.
| 
| BTW, just for the statistics: On the Duron 600 machine, for which
| I reported the athlon bug, the fix does not work. Register 0x55 has
| a default value of 0x81, but setting it to 0x01 (as the fix does)
| doesn't solve the problem, athlon optimised 2.4.9 kernels still fail
| to run. 

  I don't consider "doesn't fix the problem" a negative report in this
case. If the system worked without the patch and failed with, that would
be very negative.

| But, OTOH, the computer in question regulary oopses on 2.4.0-test7 which
| didn't have the athlon optimises page copy routine at all, so it may be
| just a case of faulty hardware :-(

  I've been cursing getting an Athlon, because some applications I got
as rpms didn't work. With the patch they do, and I have to assume that
the code notes an Athlon and tries to use whatever caused the kernel to
oops. Fortunately these are development software I'm evaluating for
someone, and I let them know what was happening before they offered it
to the public.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
