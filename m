Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267123AbTGOKmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 06:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267134AbTGOKmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 06:42:18 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:10642 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S267123AbTGOKmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 06:42:17 -0400
Date: Tue, 15 Jul 2003 11:56:57 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Matt Reppert <repp0017@tc.umn.edu>
Cc: linux@brodo.de, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.0-test1
Message-ID: <20030715105657.GA13879@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Matt Reppert <repp0017@tc.umn.edu>, linux@brodo.de,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org> <20030715001132.3b0fd7a5.repp0017@tc.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715001132.3b0fd7a5.repp0017@tc.umn.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 12:11:32AM -0400, Matt Reppert wrote:
 > I need this to build on powerpc (plus the patch by Jasper Spaans already posted).

 >   * cpufreq_parse_policy - parse a policy string
 > diff -NruX /home/arashi/kdontdiff linux-2.6.0-test1-orig/include/linux/notifier.h linux-2.6.0-test1/include/linux/notifier.h
 > --- linux-2.6.0-test1-orig/include/linux/notifier.h     2003-07-13 23:30:36.000000000 -0400
 > +++ linux-2.6.0-test1/include/linux/notifier.h  2003-07-14 23:41:56.000000000 -0400
 > @@ -65,6 +65,7 @@
 >  #define CPU_UP_CANCELED        0x0004 /* CPU (unsigned)v NOT coming up */
 >  #define CPU_OFFLINE    0x0005 /* CPU (unsigned)v offline (still scheduling) */
 >  #define CPU_DEAD       0x0006 /* CPU (unsigned)v dead */
 > +#define CPUFREQ_ALL_CPUS               ((NR_CPUS))
 > 
 >  #endif /* __KERNEL__ */
 >  #endif /* _LINUX_NOTIFIER_H */

include/linux/cpufreq.h seems a more natural place to put this.
Can you confirm that works ok on PPC? I lack hardware to test.

Otherwise, looks good.

		Dave

