Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264325AbUD0UAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbUD0UAZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 16:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264333AbUD0UAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 16:00:25 -0400
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:22949 "EHLO
	rtp-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S264325AbUD0UAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 16:00:11 -0400
X-BrightmailFiltered: true
To: "David S. Miller" <davem@redhat.com>
Cc: jmorris@redhat.com, Matt_Domsch@dell.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/libcrc32c, revised 040427
References: <Xine.LNX.4.44.0403261134210.4331-100000@thoron.boston.redhat.com>
	<yqujr7vai6k4.fsf@chaapala-lnx2.cisco.com>
	<200403302043.22938.bzolnier@elka.pw.edu.pl>
	<yqujwu52ywsy.fsf@chaapala-lnx2.cisco.com>
	<20040330192350.GB5149@lists.us.dell.com>
	<yquj1xn87mpy.fsf_-_@chaapala-lnx2.cisco.com>
	<yqujpta3y7ia.fsf_-_@chaapala-lnx2.cisco.com>
	<20040423164226.3d6fa2c3.davem@redhat.com>
	<yqujoepd9pb8.fsf_-_@chaapala-lnx2.cisco.com>
	<20040427124906.6bb753eb.davem@redhat.com>
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
Date: Tue, 27 Apr 2004 15:00:01 -0500
In-Reply-To: <20040427124906.6bb753eb.davem@redhat.com> (David S. Miller's
 message of "Tue, 27 Apr 2004 12:49:06 -0700")
Message-ID: <yqujbrld9oou.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, David S. Miller spake thusly:
> On Tue, 27 Apr 2004 14:46:35 -0500
> Clay Haapala <chaapala@cisco.com> wrote:
> 
>> Attribute(pure) was used, so I changed the patch to use the define
>> in compiler.h, as you suggest.  I will also change crc32.c, and
>> submit in a second patch.  This is a patch against 2.6.5 sources.
>> I did not change the crypto patch, as this construct was not used
>> there.
> 
> Please include linux/compiler.h if you're going to use it :-)
> 
> Once you fix that, send it again and resend the crypto part to
> me as well and I'll apply everything for you.
> 
> Thanks a lot for following up on this.

Uh .. I was prepared to terminally embarrassed by forgetting the
 #include, but I *did* compile the files, with both GCC 3.3 and 2.96, so
compiler.h must be included by something else.  Do you wish an
explicit include of compiler.h anyways?  If so, no problem, let me know.
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
  "Oh, *that* Physics Prize.  Well, I just substituted 'stupidity' for
      'dark matter' in the equations, and it all came together."
