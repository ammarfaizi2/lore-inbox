Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVKUPaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVKUPaB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbVKUPaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:30:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56042 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932308AbVKUPaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:30:01 -0500
Date: Mon, 21 Nov 2005 10:29:20 -0500
From: Dave Jones <davej@redhat.com>
To: Alexander Clouter <alex-kernel@digriz.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       blaisorblade@yahoo.it
Subject: Re: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of 'ignore nice'
Message-ID: <20051121152920.GA29968@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alexander Clouter <alex-kernel@digriz.org.uk>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	blaisorblade@yahoo.it
References: <20051110151111.GA16994@inskipp.digriz.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110151111.GA16994@inskipp.digriz.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 03:11:11PM +0000, Alexander Clouter wrote:
 > The use of the 'ignore_nice' sysfs file is confusing to anyone using it.  
 > This removes the sysfs file 'ignore_nice' and in its place creates a 
 > 'ignore_nice_load' entry which defaults to '1'; meaning nice'd processes are 
 > not counted towards the 'business' caclulation.
 > 
 > WARNING: this obvious breaks any userland tools that expected 'ignore_nice' 
 > to exist, to draw attention to this fact it was concluded on the mailing list 
 > that the entry should be removed altogether so the userland app breaks and so 
 > the author can build simple to detect workaround.  Having said that it seems 
 > currently very few tools even make use of this functionality; all I could 
 > find was a Gentoo Wiki entry.
 > 
 > Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>

 > diff -r -u -d linux-2.6.14-rc2.orig/drivers/cpufreq/cpufreq_conservative.c \
 >                 linux-2.6.14-rc2/drivers/cpufreq/cpufreq_conservative.c
 > --- linux-2.6.14-rc2.orig/drivers/cpufreq/cpufreq_conservative.c	2005-10-03 \
 >                 20:05:30.742334750 +0100
 > +++ linux-2.6.14-rc2/drivers/cpufreq/cpufreq_conservative.c	2005-10-06 \
 > 21:10:47.785133750 +0100 @@ -93,7 +93,7 @@
 >  {

This patch is horribly word-wrapped. Please resend.

		Dave
