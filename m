Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVDEIOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVDEIOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVDEIFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:05:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:53441 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261631AbVDEIDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 04:03:32 -0400
Date: Tue, 5 Apr 2005 01:03:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: stsp@aknet.ru, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.12-rc2
Message-Id: <20050405010323.0b2c5a31.akpm@osdl.org>
In-Reply-To: <42523E72.C47C21F4@tv-sign.ru>
References: <42523E72.C47C21F4@tv-sign.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> > Oleg Nesterov:
> >   o x86: fix ESP corruption CPU bug (take 2)
> 
> I don't even absolutely understand what this patch does :)
> I only send a very minor fix on top of Stas Sergeev's patch.
> 

I'm suspecting a problem in the reporting scripts.  The patch had:


From: Stas Sergeev <stsp@aknet.ru>

Attached patch works around the corruption of the high word of the ESP
register, which is the official bug of x86 CPUs.  The bug triggers only
when the one is using the 16bit stack segment, and is described here:

http://www.intel.com/design/intarch/specupdt/27287402.PDF

From: Oleg Nesterov <oleg@tv-sign.ru>

  I think that Stas tries to steal 1024 bytes from kernel's memory.

Acked-by: Linus Torvalds <torvalds@osdl.org>
Acked-by: Petr Vandrovec <vandrove@vc.cvut.cz>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Stas Sergeev <stsp@aknet.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>



It looks like the final From: was used...
