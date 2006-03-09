Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWCIVIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWCIVIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 16:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWCIVIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 16:08:34 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:13000 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751567AbWCIVId
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 16:08:33 -0500
Subject: Re: 2.6.15-rt20, "bad page state", jackd
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: nando@ccrma.Stanford.EDU, Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>
References: <1141846564.5262.20.camel@cmn3.stanford.edu>
	 <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 13:08:08 -0800
Message-Id: <1141938488.22708.28.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 09:47 +0100, Heiko Carstens wrote:
> On Wed, Mar 08, 2006 at 11:36:04AM -0800, Fernando Lopez-Lezcano wrote:
> > Hi all, I reported this in mid January (I thought I had sent to the list
> > but the report went to Ingo and Steven off list)
> > 
> > I'm seeing the same problem in 2.6.15-rt21 in some of my machines. After
> > a reboot into the kernel I just login as root in a terminal, start the
> > jackd sound server ("jackd -d alsa -d hw") and when stopping it (just
> > doing a <ctrl>c) I get a bunch of messages of this form:
> > 
> > > Trying to fix it up, but a reboot is needed
> > > Bad page state at __free_pages_ok (in process 'jackd', page c10012fc)
> > 
> > Has anyone else seen this?
> 
> Actually I have a bug report that looks quite the same. Happens on s390x
> with lots of I/O stress. But that is against vanilla 2.6.16-rc4 + additional
> patches. I need to ask to reproduce that with a plain vanilla kernel, so
> that a git bisect search might help to figure out what is wrong.
> Unfortunately it seems to take hours before we hit the bug.

In my case it is completely repeatable. 
Boot, start jackd, stop jackd -> problem appears. 

This does not happen on all computers so it would seem to me it is
related to the sound drivers. I'll try to see if there is a correlation
with the sound card being used. 

Is there anything else I could do to try to help resolve this?
-- Fernando


