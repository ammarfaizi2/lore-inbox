Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316038AbSEJPxE>; Fri, 10 May 2002 11:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316040AbSEJPxD>; Fri, 10 May 2002 11:53:03 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:23763 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S316038AbSEJPxB>; Fri, 10 May 2002 11:53:01 -0400
Date: Fri, 10 May 2002 17:53:21 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "David S. Miller" <davem@redhat.com>
cc: dizzy@roedu.net, linux-kernel@vger.kernel.org
Subject: Re: mmap, SIGBUS, and handling it
In-Reply-To: <20020510.083050.55863714.davem@redhat.com>
Message-ID: <Pine.GSO.3.96.1020510174846.12571A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, David S. Miller wrote:

>    PS: why signal(SIGBUS,SIG_IGN) doesnt work, but a user handler its called
>    if set with signal(SIGBUS,handle_sigbus) ?
> 
> How would you like the kernel to "ignore" a page fault that cannot be
> serviced?

 I would expect it to return from the handler with no action, possibly
re-executing the faulting instruction (if the reason was synchronous) and
causing an infinite loop.  For consistency, whether it makes sense, or not
(ditto for SIGSEGV, etc.). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

