Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWAPE3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWAPE3u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 23:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWAPE3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 23:29:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43422 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932206AbWAPE3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 23:29:49 -0500
Date: Sun, 15 Jan 2006 23:29:40 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git breaks Xorg on em64t
Message-ID: <20060116042940.GA3535@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060114065235.GA4539@redhat.com> <200601150105.08197.ak@suse.de> <20060115070658.GB6454@redhat.com> <200601151647.11730.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601151647.11730.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 04:47:11PM +0100, Andi Kleen wrote:
 > On Sunday 15 January 2006 08:06, Dave Jones wrote:
 > > On Sun, Jan 15, 2006 at 01:05:07AM +0100, Andi Kleen wrote:
 > >  > On Saturday 14 January 2006 23:51, Dave Jones wrote:
 > >  > > On Sat, Jan 14, 2006 at 07:43:27PM +0100, Andi Kleen wrote:
 > >  > >  > On Saturday 14 January 2006 07:52, Dave Jones wrote:
 > >  > >  > > Andi,
 > >  > >  > >  Sometime in the last week something was introduced to Linus'
 > >  > >  > > tree which makes my dual EM64T go nuts when X tries to start.
 > >  > >  > > By "go nuts", I mean it does various random things, seen so
 > >  > >  > > far..
 > >  > >  > > - Machine check. (I'm convinced this isn't a hardware problem
 > >  > >  > >   despite the new addition telling me otherwise :)
 > >  > >  >
 > >  > >  > Normally it should be impossible to cause machine checks from
 > >  > >  > software on Intel systems.
 > >  > >
 > >  > > -git7+ is the only time I've ever seen one on this box.
 > >  >
 > >  > What happens when you apply
 > >  >
 > >  > ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/page-table-setup
 > >
 > > What does this apply to ? Is it dependant on something else not
 > > merged yet ? I get rejects when I apply it to 2.6.15-git10
 > 
 > To the other patches in the quilt queue (that is the x86-64 pending
 > tree that everybody is supposed to test, but nobody does) 
 > 
 > I see there was a one liner reject with the memory hot add patch in there. I 
 > reordered it now to come first. It was for -git9.

It didn't solve my problem.   It hung at X startup again, and then
the NMI watchdog triggered.  I'll try reverting DaveA's DRM bits,
but I'm not optimistic, as a) this card isn't supported yet, and b) whilst
it's compiled in, it was disabled by X at startup due to me using dual-head.

		Dave

