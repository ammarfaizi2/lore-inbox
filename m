Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWGGICP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWGGICP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 04:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWGGICP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 04:02:15 -0400
Received: from mail.gmx.de ([213.165.64.21]:4277 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750959AbWGGICN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 04:02:13 -0400
Cc: mtk-manpages@gmx.net, mtk-lkml@gmx.net, rlove@rlove.org, roland@redhat.com,
       eggert@cs.ucla.edu, torvalds@osdl.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       drepper@redhat.com
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 07 Jul 2006 10:02:12 +0200
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
In-Reply-To: <1152256856.3111.20.camel@laptopd505.fenrus.org>
Message-ID: <20060707080212.186780@gmx.net>
MIME-Version: 1.0
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com>	
 <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com>	
 <44AD5CB6.7000607@redhat.com> <20060707043220.186800@gmx.net>	
 <44ADE9B6.1020900@redhat.com> <20060707050731.186770@gmx.net>	
 <44ADFD43.4040204@redhat.com>  <20060707070334.186790@gmx.net>
 <1152256856.3111.20.camel@laptopd505.fenrus.org>
Subject: Re: Strange Linux behaviour with blocking syscalls and stop
	signals+SIGCONT
To: Arjan van de Ven <arjan@infradead.org>
X-Authenticated: #2864774
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Von: Arjan van de Ven <arjan@infradead.org>

> 
> > There must be some framework for changing the kernel ABI over time.
> > We can't remain forever stuck with an ABI behaviour because 
> > of the development model (i.e., no 2.7/2.8). 
> 
> Hi,
> 
> this has nothing to do with the development model. 

Doh!  yes, thanks for pointing that out.

> The userspace syscall
> ABI *has* to be stable. If we make a mistake that's a high price but we
> pay it. This fwiw is one of the reasons we are/should be very careful
> with adding system calls, and make sure the behavior is indeed right.
> It's also the reason we're not so happy about new ioctls; they're
> effectively mini-system calls with the same ABI issues, but just less
> controlled/reviewed/designed/visible.

Yes.  

There have been ABI changes in the past.  In the end, I assume 
it's a question of relative desirability ("how broken is existing 
behaviour"; or: "was that behaviour ever desirable/portable 
anyway?") versus relative likelihood of breaking applications.

Cheers,

Michael
-- 


Echte DSL-Flatrate dauerhaft für 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl
