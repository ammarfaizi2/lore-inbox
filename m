Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbUBDQOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 11:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbUBDQOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 11:14:23 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:30118 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S263466AbUBDQOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 11:14:19 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH 2.6.1 -- take two] Add CRC32C chksums to crypto and lib
 routines
References: <yquj4qu8je1m.fsf@chaapala-lnx2.cisco.com>
	<Xine.LNX.4.44.0402031213120.939-100000@thoron.boston.redhat.com>
	<20040203175006.GA19751@chaapala-lnx2.cisco.com>
	<20040203185111.GA31138@waste.org>
	<yqujad40j7rn.fsf@chaapala-lnx2.cisco.com>
	<20040203172508.B26222@lists.us.dell.com>
	<20040203233737.GD31138@waste.org>
From: Clay Haapala <chaapala@cisco.com>
Organization: Cisco Systems, Inc. SRBU
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXl5ufMrp3a4OLr6ujO
 lXzChGmsblZzRzjF1+ErFRAz+KIaAAACVElEQVR4nG3TQW/aMBQAYC9IO88dguyWUomqt0DQ
 do7koO22SXFQb6uE7XIMKrFya+mhPk8D43+79+wMyrp3gnx59nvxMxmNEnIWycgH+U9E55CO
 rkZJ8hYipbXTdfcvQK/Xy6JF2zqI+qpbjZAszSDG2oXYp0FI5mOqbAeuDtLBdeuO8fNVxkzr
 E9jklKEgQWsppYYf9v4IE3i/4RiVRPneQTpoXSM8QA7un3QZQ2cl54wXIH7VDwEmrdOiZBgF
 V5BiLwLM4B3BS0ZpB24d4IvzW+QIc7/JIcAQIadF2eeUzn3FAa6xWFYUotjIRmLB7vEvCC4t
 VAugpTrC2FleLBm2wVnlAc7Dl2u5L1UozgWCjTxMW+vb4GVVFhWWFSCdKmgDMhaNFoxL3bSH
 rc/Irn1/RcWlh+UqNgHeNwishJ1L6LCpjdmGz76RmFGyuSwLgLUxJhyUlLA7fHMpeSGVPsFA
 wqtK4voI8RE+I3DsDpfamSNMpIBTKrF1yIpPMA0AzQPU5gSwCTyC/aEAtX4NM6gLM3CCziBT
 jRR+StQ/AA8a7AMuwxn0YAmcRKnVGwDRiOcw3uMWlajgAJsAPbw4OIpwrH3/vdq9B7hpl7GD
 w61A4PxwSqyH9J25gePnYdqhYjjZ5s6QCb3bwvOLJWPBFvCvWVDSthYmcff44IcacOUOt1Yv
 yGCF1+twuQtQCPjzZIaK/Lrx9+6b7TKEdXTwgz8R+uJv5K1jOcWMnO7NJ3v/QlprnzP1deUe
 8j4CpVE82MRj4j5SHGDnfvul8uGwjqNnpf4Ak4pzJDIy3lkAAAAASUVORK5CYII=
Date: Wed, 04 Feb 2004 10:14:13 -0600
In-Reply-To: <20040203233737.GD31138@waste.org> (Matt Mackall's message of
 "Tue, 3 Feb 2004 17:37:37 -0600")
Message-ID: <yquj4qu6g6ui.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110001 (No Gnus v0.1) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, Matt Mackall said:
> On Tue, Feb 03, 2004 at 05:25:08PM -0600, Matt Domsch wrote:
>> > >> +MODULE_LICENSE("GPL and additional rights");
>> > > 
>> > > "additional rights?"
>> > > 
>> > Take it up with Matt_Domsch@dell.com -- it's his code that I
>> > cribbed, so that's the license line I used.
>> 
>> The crc32 code came from linux@horizon.com with the following
>> copyright abandonment disclaimer, which is still in lib/crc32.c:
>> 
>> /*
>>  * This code is in the public domain; copyright abandoned.
>>  * Liability for non-performance of this code is limited to the
>>  * amount you paid for it.  Since it is distributed for free, your
>>  * refund will be very very small.  If it breaks, you get to keep
>>  * both pieces.  */
>> 
>> Thus GPL plus additional rights is appropriate.
> 
> Ok, makes sense for CRC32 stuff which can be easily lifted from the
> kernel or 50 other places, but not for stuff that's depends on
> cryptoapi.

Matt is correct about crypto/crc32c.c -- that should be simply "GPL".

As for the derived-from-public-domain-CRC32 stuff, should one even
claim "GPL" on it?  That would be, in effect, licensing public-domain
code and placing restrictions on it, something only a copyright holder
should be able to do, and not the intent of the author, in this case.
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
 The marketing flacks who thought the Super Bowl half-time show was the
 best way to reach 25-49-year-old males obviously surf a little too
 much Internet pr0n and read a bit much into the spam they receive.
