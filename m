Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262427AbSJER7o>; Sat, 5 Oct 2002 13:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262428AbSJER7o>; Sat, 5 Oct 2002 13:59:44 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:27663
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262427AbSJER7o>; Sat, 5 Oct 2002 13:59:44 -0400
Subject: Re: 2.5 Problem Report Status
From: Robert Love <rml@tech9.net>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org, Stian Jordet <liste@jordet.nu>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Matthew Wilcox <willy@debian.org>, Burton Windle <bwindle@fint.org>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       caligula@cam029208.student.utwente.nl, Bill Davidsen <davidsen@tmr.com>,
       Stephen Marz <smarz@host187.south.iit.edu>,
       "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>,
       Bob_Tracy <rct@gherkin.frus.com>, Dominik Brodowski <linux@brodo.de>
In-Reply-To: <Pine.LNX.4.44.0210050924470.10630-100000@dad.molina>
References: <Pine.LNX.4.44.0210050924470.10630-100000@dad.molina>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 14:05:49 -0400
Message-Id: <1033841151.742.3694.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 12:57, Thomas Molina wrote:

>    open                   04 Oct 2002 scheduling while atomic oops
>    6. http://marc.theaimsgroup.com/?l=linux-kernel&m=103270005902896&w=2
> 
> This appears to be a long-running problem.  Is it related to the group of 
> problems below involving "function might sleep while holding a lock" or is 
> it a scheduling system problem?

This is the same thing as all those "sleeping while atomic"
(might_sleep) bugs below.  It is just a debugging check.  It does the
same check as might_sleep but during schedule().

If you had specific culprits (i.e. foo() calls bar() which schedules
while foo() holds the baz lock) would be very useful.  Otherwise listing
this as a problem is not useful.

>    open                   29 Sep 2002 Oracle 9.2 goes OOM on startup
>   14. http://marc.theaimsgroup.com/?l=linux-kernel&m=103333545310595&w=2
> 
> This problem was reported for 2.5.39.  I have seen neither a followup, nor 
> a reference to a fix.  Does this problem still exist in 2.5.40?

Should be fixed in bk.

>    open                   2.5.40      init_irq() function doing unsafe 
>                                       things inside ide_lock
>   24. http://marc.theaimsgroup.com/?l=linux-kernel&m=103316967724891&w=2
> 
> Might sleep while holding a lock.

Is this still not fixed?  Ugh.

BTW, I like the fact you are listing specific atomicity issues.  Thank
you.  It is a lot more useful than just saying there are "sleeping while
atomic" bugs.

	Robert Love

