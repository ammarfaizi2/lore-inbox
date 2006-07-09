Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbWGIDVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWGIDVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 23:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbWGIDVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 23:21:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42721 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161074AbWGIDVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 23:21:24 -0400
Date: Sat, 8 Jul 2006 23:21:03 -0400
From: Dave Jones <davej@redhat.com>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk
Subject: Re: Suspend to RAM regression tracked down
Message-ID: <20060709032103.GA31395@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	cpufreq@lists.linux.org.uk
References: <1151837268.5358.10.camel@idefix.homelinux.org> <44A80B20.1090702@goop.org> <1152271537.5163.4.camel@idefix.homelinux.org> <20060707162152.GB3223@redhat.com> <1152312530.14453.16.camel@idefix.homelinux.org> <20060708062345.GB3356@redhat.com> <1152399303.14453.29.camel@idefix.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152399303.14453.29.camel@idefix.homelinux.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 08:55:02AM +1000, Jean-Marc Valin wrote:
 > > If you're prepared to play around with 'git bisect' a little, it shouldn't
 > > take that many iterations, as you've already narrowed it down quite a lot.
 > > 
 > > $ git bisect start drivers/cpufreq/cpufreq_ondemand.c
 > > $ git bisect bad
 > > $ git bisect good v2.6.12-rc5
 > > 
 > > should get you most of the way there.
 > > 
 > > http://www.kernel.org/pub/software/scm/git/docs/git-bisect.html
 > > has more info.
 > 
 > Could you give me a bit more info, since I've never used git before (I
 > only downloaded the git snapshots)? Also, if I understand correctly,
 > cpufreq_ondemand.c is the only file that could cause the problem. Is
 > that right? Also, is it possible to use an old version of it on a new
 > kernel?

Actually, before deep diving into chasing bugs in ondemand, we should
probably confirm that the same behaviour doesn't happen with a different
governor.  Can you try that ?   Try setting it to userspace, and then
running a userspace app like cpuspeed/powernowd etc.

		Dave

-- 
http://www.codemonkey.org.uk
