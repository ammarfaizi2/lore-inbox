Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135821AbREIXfp>; Wed, 9 May 2001 19:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135841AbREIXfe>; Wed, 9 May 2001 19:35:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:11990 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S135821AbREIXfU>; Wed, 9 May 2001 19:35:20 -0400
Subject: Re: Linux 2.4 Scalability, Samba, and Netbench
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, samba-technical@samba.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF59641CC4.CEBD69DC-ON88256A47.007BCFFD@LocalDomain>
From: "Bruce Allan" <bruce.allan@us.ibm.com>
Date: Wed, 9 May 2001 16:34:48 -0700
X-MIMETrack: Serialize by Router on D03NM104/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 05/09/2001 05:35:14 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Theurer wrote:
> I do have kernprof ACG and lockmeter for a 4P run.  We saw no
> significant problems with lockmeter.  csum_partial_copy_generic was the
> highest % in profile, at 4.34%.  I'll see if we can get some space on
> http://lse.sourceforge.net to post the test data.

The Netfinity system that you are using has two different supported GigE
adapters.  I assume you are using one of these types - Netfinity Gigabit
Ethernet Adapter (19K4401) and the Netfinity Gigabit Ethernet SX Server
Adapter (06P3701); using the acenic.c and e1000.c drivers, respectively.
>From what I understand after initial perusal of the two drivers, the former
has receive checksumming support on the adapter itself while the latter,
the one you are using, does not support hardware checksumming (at least, it
is not enabled by the driver).

Are you able to re-run your tests with GigE adapters that support
checksumming on the hardware instead of doing it in the kernel?  If not, I
will be running similar tests in a very similar configuration (with the
19K4401 adapters) in the near future and can share results if you'd like.

Bruce Allan/Beaverton/IBM
IBM Linux Technology Center - OS Gold
503-578-4187   T/L 775-4187
bruce.allan@us.ibm.com


