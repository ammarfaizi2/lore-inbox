Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752012AbWAEGFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbWAEGFA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbWAEGFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:05:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30636 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752012AbWAEGE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:04:59 -0500
Date: Thu, 5 Jan 2006 01:04:27 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz
Subject: Re: 2.6.15-ck1
Message-ID: <20060105060427.GE20809@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Arjan van de Ven <arjan@infradead.org>,
	ck list <ck@vds.kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	vojtech@suse.cz
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com> <20060104195726.GB14782@redhat.com> <1136406837.2839.67.camel@laptopd505.fenrus.org> <p73y81vxyci.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73y81vxyci.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 02:22:37AM +0100, Andi Kleen wrote:
 > Arjan van de Ven <arjan@infradead.org> writes:
 > 
 > 
 > > sounds like we need some sort of profiler or benchmarker or at least a
 > > tool that helps finding out which timers are regularly firing, with the
 > > aim at either grouping them or trying to reduce their disturbance in
 > > some form.
 > 
 > I did one some time ago for my own noidletick patch. Can probably dig
 > it out again. It just profiled which timers interrupted idle.
 > 
 > Executive summary for my laptop: worst was the keyboard driver (it ran
 > some polling driver to work around some hardware bug, but fired very
 > often) , followed by the KDE desktop (should be mostly
 > fixed now, I complained) and the X server and some random kernel 
 > drivers.
 > 
 > I haven't checked recently if keyboard has been fixed by now.

it was a little further down the list from the others I posted,
but it is still there fairly high in the list of offenders,
even though I wasn't touching keyboard/mouse (in fact, it was several feet
away from me, I had ssh'd to it for tests).

		Dave
