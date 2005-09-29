Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVI2Vwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVI2Vwe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVI2Vwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:52:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58534 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932301AbVI2Vwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:52:33 -0400
Date: Thu, 29 Sep 2005 17:51:53 -0400
From: Dave Jones <davej@redhat.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Alexander Clouter <alex@digriz.org.uk>,
       LKML <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk,
       Andrew Morton <akpm@osdl.org>, alex-kernel@digriz.org.uk
Subject: Re: [patch 1/1] cpufreq_conservative: invert meaning of 'ignore_nice'
Message-ID: <20050929215153.GF31516@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Blaisorblade <blaisorblade@yahoo.it>,
	Alexander Clouter <alex@digriz.org.uk>,
	LKML <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk,
	Andrew Morton <akpm@osdl.org>, alex-kernel@digriz.org.uk
References: <20050929084435.GC3169@inskipp.digriz.org.uk> <200509291346.33855.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509291346.33855.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 01:46:33PM +0200, Blaisorblade wrote:
 > On Thursday 29 September 2005 10:44, Alexander Clouter wrote:
 > > The use of the 'ignore_nice' sysfs file is confusing to anyone using.  This
 > > patch makes it so when you now set it to the default value of 1, process
 > > nice time is also ignored in the cpu 'busyness' calculation.
 > 
 > > Prior to this patch to set it to '1' to make process nice time count...even
 > > confused me :)
 > 
 > > WARNING: this obvious breaks any userland tools that expect things to be
 > > the other way round.  This patch clears up the confusion but should go in
 > > ASAP as at the moment it seems very few tools even make use of this
 > > functionality; all I could find was a Gentoo Wiki entry.
 > 
 > My suggestion on this is to rename the flag too, as ignore_nice_load (or 
 > ignore_nice_tasks, choose your way). Don't forget to do it in docs too.
 > 
 > So userspace tools will error out rather than do the reverse of what they were 
 > doing, and the user will fix the thing according to the (new) docs.

Agreed. If we change this, we change it completely.
Stefan already mentioned his app will break, and we typically don't
find out about widespread breakage until after we ship a release.

		Dave

