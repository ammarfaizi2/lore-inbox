Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271318AbTGWUxv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271319AbTGWUxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:53:51 -0400
Received: from qlink.QueensU.CA ([130.15.126.18]:11241 "EHLO qlink.queensu.ca")
	by vger.kernel.org with ESMTP id S271318AbTGWUxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:53:43 -0400
Subject: hyperthreading-aware scheduler
From: Nathan Fredrickson <8nrf@qlink.queensu.ca>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1058994421.3186.89.camel@rocky>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 17:07:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003, Andrew Theurer wrote:
> On Friday 11 July 2003 14:59, Mike Fedyk wrote:
> > On Fri, Jul 11, 2003 at 02:37:12PM -0500, Andrew Theurer wrote:
> > > On Friday 11 July 2003 09:02, Dave Jones wrote:
> > > > Process scheduler improvements.
> > > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > - Scheduler is now Hyperthreading SMP aware and will disperse processes
> > > >   over physically different CPUs, instead of just over logical CPUs.
> > >
> > > I'm pretty sure this is not in 2.5 (unless it's in bk after 2.5.75)
> >
> > wasn't this merged back in 2.4.6x?
> 
> I believe that was support of, not enhancement for HT.  Actually there may 
> have been some enhancements in other areas, but not scheduler.

Now that we have support of HT, what is the status hyperthreading-aware
scheduler?  Do any of the testing-trees have a hyperthreading-aware
scheduler?

Ingo has some HT-scheduler patches here: 
http://people.redhat.com/mingo/O(1)-scheduler/
The most recent is for 2.5.68, but unfortunately due to other problems I
have only been able to run kernels 2.5.70 and greater.  Also my attempts
at forward-porting Ingo's 2.5.68 patch have not been successful.

I have access to dual and quad HT-enabled systems and would be happy to
do some testing as I learn more about the scheduler.  SMP w/ HT systems
have scheduling issues that don't exist in a UP w/ HT system.  For
example when there are 4 compute intensive threads in quad HT system
they should be scheduled on physically unique processors.  This does not
happen with the current scheduler even in an otherwise completely idle
system.  Two threads often end up on the same physical processor and
remain there due to their affinity.

Nathan

