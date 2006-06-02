Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWFBTof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWFBTof (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWFBTof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:44:35 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:14800 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750765AbWFBToe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:44:34 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 21:42:43 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 00/18] ieee1394: misc updates
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
Message-ID: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.888) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

here is a bunch of IEEE 1394 subsystem patches which have been floating
around for a while.  Some of them have already been in git-ieee1394 and/
or in -mm (before git-ieee1394 dropout).  All of them went through
linux1394-devel, except the sem2mutex patch.  They do not depend on each
other except where noted.  Noted below are the dates of first posts, not
of subsequent patch updates or resubmissions.  Two or three recent 1394
subsystem patches which may need more review or rework are not included
here.

Dear lkml readers, the age of some of the patches does not mean they
have become perfect.  Yell if you spot any goofiness.

[01/18] video1394: be quiet
2006-02-24 Daniel Drake

[02/18] ohci1394.c: function calls without effect
2006-03-09 me, ripped from a patch by Adrian Bunk

[03/18] sbp2: make TSB42AA9 workaround specific to Momobay CX-1
2006-03-19 me

[04/18] Semaphore to mutex conversion. (a.k.a. sem2mutex-drivers-ieee1394)
2006-01 or before, Arjan van de Ven

[05/18] raw1394: fix whitespace after x86_64 compat patch
2006-03-26 me

[06/18] ieee1394/ohci1394: CycleTooLong interrupt management
2006-03-17 Jean-Baptiste Mur

[07/18] ieee1394: support for slow links or slow 1394b phy ports
2006-03-26 me
Fixes a long-standing incompatibility to two less common classes of IEEE
1394a and IEEE 1394b devices (devices with link speed slower than PHY
speed, devices with S100B...S400B PHY ports) and to the case of two
1394b PHYs connected via 1394a cable.
Still missing feature: expose negotiated port speeds to userspace

[08/18] ieee1394: save RAM by using a single tlabel for broadcast transactions
2006-03-26 me
saves much less RAM than length of title suggests :-)

[09/18] sbp2: remove manipulation of inquiry response
2006-04-08 me

[10/18] sbp2: log number of supported concurrent logins
2006-04-14 me, Jody

[11/18] ieee1394: extend lowlevel API for address range properties
2006-04-15 me
apply together with 12/18

[12/18] ohci1394: set address range properties
2006-04-15 me

[13/18] ohci1394: make phys_dma parameter read-only
2006-04-15 me

[14/18] sbp2: sbp2 remove ohci1394 specific constant
2006-04-23 me
depends on 11/18 + 12/18

[15/18] sbp2: fix S800 transfers if phys_dma is off
2006-04-15 me

[16/18] Update feature removal of obsolete raw1394 ISO requests.
2006-04-18 Jody
This documentation patch could go into Linux 2.6.17.
Necessity of delay was discussed in http://lkml.org/lkml/2006/4/8/72

[17/18] sbp2: provide helptext for CONFIG_IEEE1394_SBP2_PHYS_DMA and mark it experimental
2006-05-07 me

[18/18] sbp2: use __attribute__((packed)) for on-the-wire structures
2006-05-07 me

-- 
Stefan Richter
-=====-=-==- -==- ---=-
http://arcgraph.de/sr/

