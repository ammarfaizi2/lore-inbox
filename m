Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268506AbUHLK5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268506AbUHLK5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 06:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268508AbUHLK5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 06:57:54 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:37855 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268506AbUHLK5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 06:57:52 -0400
Date: Thu, 12 Aug 2004 11:56:29 +0100
From: Dave Jones <davej@redhat.com>
To: "Lamont R. Peterson" <lamont@gurulabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Transition /proc/cpuinfo -> sysfs
Message-ID: <20040812105629.GA7359@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Lamont R. Peterson" <lamont@gurulabs.com>,
	linux-kernel@vger.kernel.org
References: <20040811224117.GA6450@plexity.net> <1092287009.2250.9.camel@wraith.lrp.advansoft.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092287009.2250.9.camel@wraith.lrp.advansoft.us>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 11:03:29PM -0600, Lamont R. Peterson wrote:

 > > - On an HT setup, do we want link(s) pointing to sibling(s)?
 > 
 > I like this idea, even if it is not necessary because siblings should be
 > listed sequentially together.  i.e. two physical CPUs with HT would be
 > cpu0, cpu1, cpu2 & cpu3.  Obviously, cpu0 & cpu1 go together and cpu2 &
 > cpu3 also go together.

I'll bet *any* userspace code wanting to know this info would be simpler
to write if you do the cpuid calls in the app and parse internally than
walking sysfs to form an interpretation.

 > > - Instead of dumping the "flags" field, should we just dump cpu
 > >   registers as hex strings and let the user decode (as the comment
 > >   for the x86_cap_flags implies.
 > 
 > I like this.  In fact, if it goes this way, then I will write a
 > "cpuinfo" program that will do all the decoding as a generic tool.

http://www.codemonkey.org.uk/projects/x86info/

Ok, its x86/amd64 specific, but it does all this parsing and the like
where it should be -- userspace.

		Dave

