Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVFBWEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVFBWEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVFBWEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:04:43 -0400
Received: from dvhart.com ([64.146.134.43]:6311 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261356AbVFBWDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:03:22 -0400
Date: Thu, 02 Jun 2005 15:03:18 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Adam Litke <agl@us.ibm.com>, Enrique Gaona <egaona@us.ibm.com>
Subject: [ANNOUNCE] automated linux kernel testing results
Message-ID: <531740000.1117749798@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I've finally got this to the point where I can publish it.

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html

Currently it builds and boots any mainline, -mjb, -mm kernel within
about 15 minutes of release. runs dbench, tbench, kernbench, reaim and fsx.
Currently I'm using a 4x AMD64 box, a 16x NUMA-Q, 4x NUMA-Q, 32x x440 (ia32)
PPC64 Power 5 LPAR, PPC64 Power 4 LPAR, and PPC64 Power 4 bare metal system.
The config files it uses are linked by the machine names in the column 
headers.

Andrew, you should be able to see build failures in -mm more easily now ;-)
I'll work on some automatic email triggers to you if you want them.

Thanks to all the other IBM people who've worked on the ABAT test system 
that this stuff relies on - too many to list, but especially Andy, Adam,
and Enrique, who have fixed endless bugs, and put up with my incessant 
bitching about it all not working as it should ;-)

It will do various other bits and pieces ... more profiling, more tests,
it'll do patches, etc as well. I don't want to push much volume up to
kernel.org (I just copy a small subset of the generated files right now),
but there are more runs queued with some fixup patches on top of -mm tree,
for example. It did also do -bk and -git nightly builds, they're not in 
this matrix, but I'll add them back soon.

Andrew, if you want some other test added to the mix, please let me 
know ... though theoretically we can do multi-machine tests (eg networked),
I want to stick with single-machine ones for now. There's a huge pile of
tests we intend to add ... but I thought I'd throw the general results
mechanism out there for people to look at.

Clicking on the failure ones error codes should take you to somewhere
vaguely helpful to diagnose it. Clicking on the job number just below
that takes you to the info I'm publishing right now, which should 
include perf results and profiles, etc. I'll add graphs, etc later,
comparing performance across kernels (I have them ... just not automated).

M.

