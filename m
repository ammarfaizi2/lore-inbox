Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265561AbTFSNoF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 09:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265614AbTFSNoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 09:44:05 -0400
Received: from gherkin.frus.com ([192.158.254.49]:48512 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S265561AbTFSNoD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 09:44:03 -0400
Subject: Re: [PATCH] Make gcc3.3 Eliminate Unused Static Functions
In-Reply-To: <20030619132810.GA6906@wohnheim.fh-wedel.de> =?ISO-8859-1?Q?from_J=F6rn_Engel_at_Jun_19=2C_2003_03=3A28=3A10_pm?=
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Date: Thu, 19 Jun 2003 08:57:59 -0500 (CDT)
Cc: Tom Rini <trini@kernel.crashing.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Bernd Eckenfels <ecki-lkm@lina.inka.de>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UNKNOWN-8BIT
Message-Id: <20030619135800.6D4514F01@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> I haven't seen a clear compiler bug yet, but found two bugs in
> assembler code with 2.95.3 that compiled without problems with 3.2.x.
> One of them has actually hit people, as you could see in the code.
> Most symptoms were "fixed", but the cause remained.

Another data point...  Earlier (I *think* it was this thread) someone
mentioned problems with trying to build glibc with gcc 3.x and "ls"
segfaulting.  I've recently upgraded portions of my system (including
libraries and compilers) with the packages from the Slackware 9.0 CD.
I expect a certain amount of pain (due to library version conflicts)
every time I go through the upgrade process, but this time the pain
feels different...  I absolutely cannot get getty and uugetty from the
getty-ps-2.1.0 package to work: segmentation faults.  Even tried building
from source: no good.  My old getty and uugetty binaries (version 2.0.7j)
seem to work ok with the new libraries, but rebuilding the 2.0.7j code
with gcc-3.2.2 results in segfaults.

The behavior seems to be independent of kernel version (2.5.70-2.5.72).
Here's the relevant version list (referenced libraries reported by ldd):

kernel 2.5.72
glibc 2.3.1
libtermcap 2.0.8
ld-2.3.1
gcc 3.2.2
binutils 2.13.90.0.18

The Slackware default install uses agetty rather than the getty-ps
package, which may partly explain why my particular symptom hasn't been
reported previously (to my knowledge).  I'm curious to know if this
problem exists with a virgin Slackware 9 installation, and will probably
have an answer by this weekend, time permitting.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
