Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310156AbSCAXHF>; Fri, 1 Mar 2002 18:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310157AbSCAXGu>; Fri, 1 Mar 2002 18:06:50 -0500
Received: from schmee.sfgoth.com ([63.205.85.133]:16135 "EHLO
	schmee.sfgoth.com") by vger.kernel.org with ESMTP
	id <S310156AbSCAXGm>; Fri, 1 Mar 2002 18:06:42 -0500
Date: Fri, 1 Mar 2002 15:06:09 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: Robert Love <rml@tech9.net>, fisaksen@bewan.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spinlock not locked when unlocking in atm_dev_register
Message-ID: <20020301150609.A89500@sfgoth.com>
In-Reply-To: <20020301163936.7FA725F963@postfix2-2.free.fr> <20020301163936.7FA725F963@postfix2-2.free.fr> <1015020950.11295.25.camel@phantasy> <5.1.0.14.2.20020301143010.0d552be8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <5.1.0.14.2.20020301143010.0d552be8@mail1.qualcomm.com>; from maxk@qualcomm.com on Fri, Mar 01, 2002 at 02:32:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maksim Krasnyanskiy wrote:
> btw ATM locking seems to be messed up. Is anybody working on that ?

Yes, pretty badly.  What we (the atm folks) really need to do for 2.5 is
rewrite a lot of code.  The current driver model predates SMP in the kernel
and it's pretty much impossible to make a driver 100% SMP correct (although,
in practice, you can get pretty close and keep the races pretty tiny)
Really a lot of the driver model needs to be rethought.

As for maintainership I readily admit I haven't spent nearly as much time
as I would have liked on the ATM stuff in the last year or so.  Too much
other work to do, etc.  I'm really hoping to get some free time to play
with stuff in the next couple months...  There are others actively working
on stuff.  Particularly Paul Schroeder at IBM did a lot of good work on
the (long-suffering) userland tools.

Anyway I have been thinking that we should start kicking around ideas for
the next-generation ATM code.  I'd recommend interested parties subscribe
to the linux-atm-general mailing list:
  http://lists.sourceforge.net/lists/listinfo/linux-atm-general

-Mitch
