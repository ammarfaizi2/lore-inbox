Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVBPVyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVBPVyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVBPVyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:54:52 -0500
Received: from mail.velocity.net ([66.211.211.55]:12980 "EHLO
	mail.velocity.net") by vger.kernel.org with ESMTP id S262091AbVBPVyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:54:46 -0500
X-AV-Checked: Wed Feb 16 16:54:46 2005 clean
Subject: Re: Oops in 2.6.10-ac12 in kjournald (journal_commit_transaction)
From: Dale Blount <linux-kernel@dale.us>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050216200441.GH19871@charite.de>
References: <20050215145618.GP24211@charite.de>
	 <20050216153338.GA26953@atrey.karlin.mff.cuni.cz>
	 <20050216200441.GH19871@charite.de>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 16:54:45 -0500
Message-Id: <1108590885.17089.17.camel@dale.velocity.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-16 at 21:04 +0100, Ralf Hildebrandt wrote:
> * Jan Kara <jack@suse.cz>:
> 
> >   I guess the system is SMP...
> 
> Indeed it is. Dual Xeon with SMP.
> 

This looks very similar (at least to me) to an OOPS I posted with 2.6.9
on 12/03/2004.
http://marc.theaimsgroup.com/?l=linux-kernel&m=110210705504716&w=2

My system is also a dual Xeon using SMP and Hyperthreading
(/proc/cpuinfo shows 4 cpus).
Mine, like Ralf's, is also a mail server running postfix using ext3 for
the spool directory.

> > but it seems similar like a several other oopses I've seen reported
> > recently. Is this the first time you hit this bug?
> 
> It's actually the second time. The first time it hit the SAME box but
> with kernel-2.6.10 (vanilla) after 30 days of uptime. Nobody had a
> camera at hand, so I couldn't take a photo.
> 

I've actually hit this bug (assuming it's the same) with 2.6.10 also.  I
had to power cycle remotely and unfortunately didn't have the serial
console logging enabled when it happened with 2.6.10.  I upgraded from
2.4.23 to 2.6.8.1 and crashed within a week, and continued to crash at
least monthly after that.  It had been running 2.4.23 for 200+ days with
no problems.

Hope this helps trace it back.

Dale

