Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271754AbRICRJQ>; Mon, 3 Sep 2001 13:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271756AbRICRJF>; Mon, 3 Sep 2001 13:09:05 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:9225 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S271755AbRICRIy>; Mon, 3 Sep 2001 13:08:54 -0400
Message-ID: <3B93B95E.F30F1F8B@loewe-komp.de>
Date: Mon, 03 Sep 2001 19:09:50 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [bug report] NFS and uninterruptable wait states
In-Reply-To: <m3zo8cp93a.fsf@belphigor.mcnaught.org>  <01090310483100.26387@faldara> <32526.999534512@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> doug@wireboard.com said:
> >  NFS does this (wait in D state) by default in order to prevent naive
> > applications from getting timeout errors that they're not equipped to
> > handle--the idea being that, if an NFS server goes down, programs
> > using it will simply freeze and recover once it returns, rather than
> > getting a timeout error and possibly becoming confused.
> 
> Timeouts are a completely separate issue, surely? Applications ought to be
> able to deal with getting a _signal_ during a system call, whatever happens.
> 
> IMO, sleeping in state TASK_UNINTERRUPTIBLE in any situation where you can't
> prove that the wakeup _will_ happen and will happen _soon_ should be
> considered a bug - it's almost always just because someone hasn't bothered
> to implement the cleanup code required for dealing with being interrupted.
> 
> /me tries to work out why anyone would ever want filesystem accesses to be
> uninterruptible.
> 
Because historically the 'D' meant "wait on _D_isk" 8-)
