Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUCKQfL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbUCKQfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:35:10 -0500
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:59039 "EHLO
	rtp-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S261496AbUCKQfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:35:03 -0500
X-BrightmailFiltered: true
To: Jouni Malinen <jkmaline@cc.hut.fi>
Cc: James Morris <jmorris@redhat.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
References: <20040311030035.GA3782@jm.kir.nu>
	<Xine.LNX.4.44.0403102302450.935-100000@thoron.boston.redhat.com>
	<20040311060818.GA3739@jm.kir.nu>
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
Date: Thu, 11 Mar 2004 10:34:58 -0600
In-Reply-To: <20040311060818.GA3739@jm.kir.nu> (Jouni Malinen's message of
 "Wed, 10 Mar 2004 22:08:19 -0800")
Message-ID: <yqujr7vztk99.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110001 (No Gnus v0.1) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Jouni Malinen outgrape:
> On Wed, Mar 10, 2004 at 11:06:37PM -0500, James Morris wrote:
> 
>> I can't reproduce it now either (AFAICR, it oopsed in test_hash().
>> 
>> I suspect it may have been caused by loading tcrypt module which
>> was out of sync with the digest setkey change.
> 
> That's possible. It didn't fail in my test with an updated version
> from the BK repository either, so I would assume this issue can be
> called resolved.
> 
> Here's the digest setkey part of the previous combined patch; I'll
> send a patch for Michael MIC separately.
> 
> 
> 
> Added support for using keyed digest with an optional dit_setkey
> handler.  This does not change the behavior of the existing digest
> algorithms, but allows new ones to add setkey handler that can be
> used to initialize the algorithm with a key or seed. setkey is to be
> called after init, but before any of the update call(s).
> 
> [ ... patch omitted ... ]

OK, so I should recode CRC32C to be a variation of digest that employs
a setkey() handler, right?  Should be no problem.

Can I get to a reasonable development environment by starting with
2.6.3, and adding the patch you just sent?  Or, do I need the Michael
MIC patch, as well?
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
  Windows XP 'Reloaded'?  *Reloaded?*  Have they no sense of irony?
