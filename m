Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWGBUPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWGBUPw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 16:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWGBUPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 16:15:52 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:13445 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750707AbWGBUPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 16:15:52 -0400
Date: Sun, 2 Jul 2006 16:10:55 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] i386: clean up user_mode() use
To: Ingo Molnar <mingo@elte.hu>
Cc: pageexec <pageexec@freemail.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200607021612_MC3-1-C3FD-CC89@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060702133718.GA27549@elte.hu>

On Sun, 2 Jul 2006 15:37:18 +0200, Ingo Molnar wrote:

> > to avoid such mistakes in the future, the suggested solution is to 
> > make user_mode() on i386 consistent with the generic expectation and 
> > make it detect any user mode execution context, that is, it should 
> > take the role of user_mode_vm() and a new user_mode_novm() is 
> > introduced for the i386 specific cases where v86 mode can be excluded. 
> > in short, the patch simply does a
> > 
> >   user_mode_vm -> user_mode
> >   user_mode    -> user_mode_novm
> > 
> > substitution as appropriate.
> > 
> > Signed-off-by: PaX Team <pageexec@freemail.hu>
> 
> agreed!
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

Please make that second one

        user_mode_novm86

Otherwise people might think it means "user mode no virtual memory."

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
