Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312400AbSCUSDN>; Thu, 21 Mar 2002 13:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312409AbSCUSDD>; Thu, 21 Mar 2002 13:03:03 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:7950 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S312400AbSCUSCp>; Thu, 21 Mar 2002 13:02:45 -0500
To: Bob Miller <rem@osdl.org>
Cc: Bob_Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.7: acct.c oops
In-Reply-To: <m16o4pO-0005khC@gherkin.frus.com>
	<20020321092526.A11399@doc.pdx.osdl.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 22 Mar 2002 02:59:31 +0900
Message-ID: <87lmclyf7g.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Miller <rem@osdl.org> writes:

> On Thu, Mar 21, 2002 at 09:50:10AM -0600, Bob_Tracy wrote:
> > I might have missed this one.  After all, this is a pretty low-traffic
> > list :-).
> > 
> > Running "accton" (with or without arguments) consistently generates
> > an oops at linux/kernel/acct.c:169
> > 	BUG_ON(!spin_is_locked(&acct_globals.lock));
> > 
> > I first saw this when shutting down my machine.  The shutdown scripts
> > run "accton" without any arguments to terminate accounting, regardless
> > of whether it's running.
> > 
> > 2.5.7 kernel on a Dell laptop running a Mandrake distribution.
> > 
> > -- 
> > -----------------------------------------------------------------------
> > Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
> > rct@frus.com
> > -----------------------------------------------------------------------
> Hi Tracy,
> 
> Do you have the rest of the of oops message passed through ksymoops?
> I'll also try to reproduce here.  TIA.

Probably, his kernel is not SMP. if so, spin_is_locked() return 0 always.

Regards.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
