Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUHSTOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUHSTOu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUHSTOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:14:50 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:30850 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267283AbUHSTOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:14:42 -0400
From: jmerkey@comcast.net
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, <jmerkey@drdos.com>
Subject: Re: kallsyms 2.6.8 address ordering
Date: Thu, 19 Aug 2004 19:14:40 +0000
Message-Id: <081920041914.20259.4124FC20000DAD5E00004F232200762302970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> On Thu, 19 Aug 2004 jmerkey@comcast.net wrote:
> 
> > kallsyms in 2.6.8 is presenting module symbol tables with out of order
> > addresses in 2.6.X.  This makes maintaining a commercial kernel debugger
> > for Linux 2.6 kernels nighmareish. 
> 
> How hard could it be to sort the table in your debugger ?
> 

How about not sorting it at all and not being required to increase memory consumption for 
debugging purposes?  



> > Also, the need to kmalloc name strings (like kdb does) from kallsyms in
> > kdbsupport.c while IN THE DEBUGGER makes it impossible to debug large
> > portions of the kernel code with kdb, so I have rewritten large sections
> > of kallsyms.c to handle all these broken, brain-dead cases in mdb and I
> > am not relying much on kdb hooks anymore.
>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Sounds like your commercial debugger might just be violating
> the GPL ;)

No.  it's not.  Chris makes a suggestion I should make it work on unpatched kernels.  
I will address on his thread.

Jeff

> 
> -- 
> "Debugging is twice as hard as writing the code in the first place.
> Therefore, if you write the code as cleverly as possible, you are,
> by definition, not smart enough to debug it." - Brian W. Kernighan
> 
