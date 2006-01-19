Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161412AbWASUdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161412AbWASUdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161416AbWASUdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:33:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12477 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161412AbWASUdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:33:36 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Sean Hefty <mshefty@ichips.intel.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [openib-general] Re: RFC: ipath ioctls and their replacements
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	<m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>
	<1137688158.3693.29.camel@serpentine.pathscale.com>
	<m1hd80oz9b.fsf@ebiederm.dsl.xmission.com>
	<43CFDF5F.5060409@ichips.intel.com>
	<1137696901.3693.66.camel@serpentine.pathscale.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 19 Jan 2006 13:31:34 -0700
In-Reply-To: <1137696901.3693.66.camel@serpentine.pathscale.com> (Bryan
 O'Sullivan's message of "Thu, 19 Jan 2006 10:55:01 -0800")
Message-ID: <m1oe28nemx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> writes:

> On Thu, 2006-01-19 at 10:50 -0800, Sean Hefty wrote:
>
>> I'm not familiar with the driver, but would the lower level verbs interfaces 
>> work for this?  Could you just post whatever datagrams that you want directly
> to
>> your management QPs?
>
> Our lowest-level driver works in the absence of any IB support being
> compiled into the kernel, so in that situation, there are no QPs or any
> other management infrastructure present at all.  All of that stuff lives
> in a higher layer, in which situation the cut-down subnet management
> agent doesn't get used, and something like OpenSM is more appropriate.

Ok this is one piece of the puzzle.  At your lowest level your hardware
does not have QP's but it does have something similar to isolate a userspace
process correct?

Which sounds like one problem with the IB layer is that it assumes QPs instead
of a slight abstraction of that concept.

Eric
