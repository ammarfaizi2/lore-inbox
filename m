Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284972AbRLKLdk>; Tue, 11 Dec 2001 06:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284979AbRLKLdb>; Tue, 11 Dec 2001 06:33:31 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:18672 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S284971AbRLKLdO>; Tue, 11 Dec 2001 06:33:14 -0500
Date: Tue, 11 Dec 2001 11:33:06 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Timothy Shimmin <tes@boing.melbourne.sgi.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Nathan Scott <nathans@sgi.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [PATCH] Revised extended attributes interface
Message-ID: <20011211113306.E2268@redhat.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <20011210115209.C1919@redhat.com> <20011211122258.V61575@boing.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011211122258.V61575@boing.melbourne.sgi.com>; from tes@boing.melbourne.sgi.com on Tue, Dec 11, 2001 at 12:22:58PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 11, 2001 at 12:22:58PM +1100, Timothy Shimmin wrote:

> Could this not be catered for independent of the proposed EA interface
> for getting/setting/removing EAs ?

Definitely.  The whole problem I pointed out with the EA interface was
that it didn't talk about ACLs at all.  So, sure, it gives us an API
for arbitrary EAs, but it does absolutely nothing to help us unify ACL
APIs.  In effect it is far _too_ extensible: we need to have some
agreement on how it can be used if the different ACL applications are
to have any hope of working together.

The bright point is that this can be done reasonably well in user
space, if we're careful (but we still need to worry about exactly how
the kernel will deal with validating ACE chains --- we need to specify
whether EAs in the system namespace are expected to be stored verbatim
or whether the filesystem is permitted to interpret their semantics
intelligently.)

Cheers,
 Stephen
