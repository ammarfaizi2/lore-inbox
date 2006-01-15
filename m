Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751862AbWAOHHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbWAOHHF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 02:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWAOHHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 02:07:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751862AbWAOHHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 02:07:04 -0500
Date: Sun, 15 Jan 2006 02:06:58 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git breaks Xorg on em64t
Message-ID: <20060115070658.GB6454@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060114065235.GA4539@redhat.com> <200601141943.28027.ak@suse.de> <20060114225137.GB23021@redhat.com> <200601150105.08197.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601150105.08197.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 01:05:07AM +0100, Andi Kleen wrote:
 > On Saturday 14 January 2006 23:51, Dave Jones wrote:
 > > On Sat, Jan 14, 2006 at 07:43:27PM +0100, Andi Kleen wrote:
 > >  > On Saturday 14 January 2006 07:52, Dave Jones wrote:
 > >  > > Andi,
 > >  > >  Sometime in the last week something was introduced to Linus'
 > >  > > tree which makes my dual EM64T go nuts when X tries to start.
 > >  > > By "go nuts", I mean it does various random things, seen so
 > >  > > far..
 > >  > > - Machine check. (I'm convinced this isn't a hardware problem
 > >  > >   despite the new addition telling me otherwise :)
 > >  >
 > >  > Normally it should be impossible to cause machine checks from software
 > >  > on Intel systems.
 > >
 > > -git7+ is the only time I've ever seen one on this box.
 > 
 > What happens when you apply
 > 
 > ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/page-table-setup

What does this apply to ? Is it dependant on something else not
merged yet ? I get rejects when I apply it to 2.6.15-git10

I don't have time to fix it up by hand right now (I was going to set
a build going before I turned in for the night..)

I'll poke at it again tomorrow.

Another datapoint btw: I've another EM64T that works just fine.
The one that fails is the only one that isn't using onboard VGA,
this one has a PCIE Radeon.  Given it happens when X is starting up,
it could be that the X radeon driver does something special which
is why others aren't seeing this.

		Dave
