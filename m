Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbSJORdD>; Tue, 15 Oct 2002 13:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264879AbSJORdD>; Tue, 15 Oct 2002 13:33:03 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:58784 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264878AbSJORdC>;
	Tue, 15 Oct 2002 13:33:02 -0400
Importance: Normal
Sensitivity: 
Subject: Re: Linux v2.5.42
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF4DD9FD79.C86F4C35-ON85256C52.005DB3B6@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Tue, 15 Oct 2002 12:43:11 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/15/2002 01:38:31 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

You have undoubtedly heard from many people their
opinions of some of the disputed design issues of
EVMS. I would very much like to hear what your
opinions are on the following points:

1) In-kernel vs user space discovery

Today, EVMS employs in-kernel discovery. Some
members of the kernel community has expressed
their desire to rip all existing kernel code for
discovery (of partitions, etc) and move this
support into user space.

Do you agree that having only user space
discovery is good idea? And if so, will this be
a requirement for 2.6?

2) Separate vol. mgmt. subsystems vs.
   Integrating vol. mgmt into the block layer

Christoph's new proposal seems to be to
consolidate all vol. mgmt. into a new block
layer/device interface. In the long term, this
might be the right direction to go. However,
this does not seem likely to be completed in
the 2.5/2.6 timeframe. What will be used for
volume management until then?

Assuming compatible metadata formats, it seems
that MD, LVM, and EVMS as separate components
could be used until such a common infrastructure
was in place. At that point, the existing drivers
could be migrated to using the new infrastructure.

3) Generic access to intermediate (storage)
   points that comprise a volume.

One of EVMS' original design goals was to
abstract internals of the composition of volumes
from the user and the block layer. There was
benefits in doing this, primarily in not wasting
some limited resources (ie. majors and minors),
as well as some memory. Each EVMS volume is
exported as a standard block device, but the
internal composition of that volume is considered
EVMS private data and not exposed directly to
the outside world. Thus member elements of a
volume are not accessible through the generic
block device operations.

Other (potential volume manager) implementation
have typically represented member elements as
independent block devices. Each being accessible
through the generic block device operations.

What's your opinion on the abstraction that EVMS
currently provides?

Mark


