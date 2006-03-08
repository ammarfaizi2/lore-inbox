Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751971AbWCHBOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbWCHBOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbWCHBOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:14:05 -0500
Received: from colin.muc.de ([193.149.48.1]:29457 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751971AbWCHBOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:14:04 -0500
Date: 8 Mar 2006 02:13:55 +0100
Date: Wed, 8 Mar 2006 02:13:55 +0100
From: Andi Kleen <ak@muc.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Dominik Karall <dominik.karall@gmx.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm2
Message-ID: <20060308011355.GA79280@muc.de>
References: <20060303045651.1f3b55ec.akpm@osdl.org> <200603052354.02828.dominik.karall@gmx.net> <20060306214357.0b299686.akpm@osdl.org> <200603071533.41430.dominik.karall@gmx.net> <1141752322.19827.3.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141752322.19827.3.camel@leatherman>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 09:25:12AM -0800, john stultz wrote:
> On Tue, 2006-03-07 at 15:33 +0100, Dominik Karall wrote:
> > On Tuesday, 7. March 2006 06:43, Andrew Morton wrote:
> > > Dominik Karall <dominik.karall@gmx.net> wrote:
> > > > On Friday, 3. March 2006 13:56, Andrew Morton wrote:
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc
> > > > >5/2. 6.16-rc5-mm2/
> > > >
> > > > hi,
> > > > I don't know why, but it seems that the kernel doesn't use the correct
> > > > BIOS time. I set it to the 23:30 and after booting I got ~01:00 (next
> > > > day).
> > >
> > > Is that new behaviour?  What's the most recent -mm kernel which that
> > > machine ran?
> > >
> > > The full dmesg output might tell us something.
> > 
> > I bootet 2.6.16-rc5 now, but the bug is still present. I set BIOS time to 
> > 15:07 and after booting linux showed 17:35.
> 
> Interesting. Right off, I'm not sure where this would be coming from.
> >>From your dmesg it looks like this is running an x86-64 kernel, correct?
> Andi, do you have any ideas?

Normally the time is read again in the startup scripts of the distribution.
Sounds like he configured the wrong time zone. Usually distributions
can be configured to assume UTC real clock time or local time RTC.

You can test that theory by commenting out any calls to hwclock
in your boot scripts. 

But that behaviour should be the same in all kernels.

-Andi
