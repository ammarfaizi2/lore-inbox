Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161151AbWJVCuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbWJVCuW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 22:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWJVCuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 22:50:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:20619 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751762AbWJVCuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 22:50:21 -0400
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: PAE broken on Thinkpad
Date: Sun, 22 Oct 2006 04:50:15 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <1161472697.5528.6.camel@localhost.localdomain> <p73mz7pm7lt.fsf@verdi.suse.de> <1161484239.5528.8.camel@localhost.localdomain>
In-Reply-To: <1161484239.5528.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610220450.15824.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 04:30, john stultz wrote:
> On Sun, 2006-10-22 at 04:01 +0200, Andi Kleen wrote:
> > john stultz <johnstul@us.ibm.com> writes:
> > 
> > > Yea. So I know I probably shouldn't run a PAE kernel on my 1Gig laptop,
> > > but in trying to do so I found it won't boot.
> > 
> > You don't say what version?
> 
> Sorry, the current -git.

Normally the early exception handler should print a backtrace, i wonder
why that didn't work.

Can you change the

static int current_ypos = 25

in arch/x86_64/kernel/early_printk.c to

static int current_ypos = 0

and see if that displays the backtrace?

-Andi
