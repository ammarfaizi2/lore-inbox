Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbTBNSBW>; Fri, 14 Feb 2003 13:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbTBNSBV>; Fri, 14 Feb 2003 13:01:21 -0500
Received: from almesberger.net ([63.105.73.239]:64525 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S264001AbTBNSBV>; Fri, 14 Feb 2003 13:01:21 -0500
Date: Fri, 14 Feb 2003 15:10:01 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Corey Minyard <cminyard@mvista.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, suparna@in.ibm.com,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
Message-ID: <20030214151001.F2092@almesberger.net>
References: <20030211191027.A2999@in.ibm.com> <3E490374.1060608@mvista.com> <20030211201029.A3148@in.ibm.com> <3E4914CA.6070408@mvista.com> <m1of5ixgun.fsf@frodo.biederman.org> <3E4A578C.7000302@mvista.com> <m13cmty2kq.fsf@frodo.biederman.org> <3E4A70EA.4020504@mvista.com> <20030214001310.B2791@almesberger.net> <3E4CFB11.1080209@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4CFB11.1080209@mvista.com>; from cminyard@mvista.com on Fri, Feb 14, 2003 at 08:20:01AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard wrote:
> Yes, we were talking about temporary stopgaps.

Yes, that's what Suparna and Eric were discussing :-)

> But, I had another idea.  What about using power management?  If you 
> suspended everything, would that be good enough.  I looked at a few 
> drivers, and it seemed so.

As long as you don't need any form of synchronization to power
down a device, and if it comes up silent (i.e. no "sleep" mode,
in which it still has enough power to remember DMA lists and
such), that would work.

I'd suspect that power management requiries you to synchronize,
so we're back to square one.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
