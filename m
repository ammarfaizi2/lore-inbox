Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbTHZTez (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbTHZTez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:34:55 -0400
Received: from holomorphy.com ([66.224.33.161]:54961 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261963AbTHZTew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:34:52 -0400
Date: Tue, 26 Aug 2003 12:35:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mulix@mulix.org, arjanv@redhat.com, mingo@redhat.com,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-ID: <20030826193552.GU4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, mulix@mulix.org, arjanv@redhat.com,
	mingo@redhat.com, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <20030825231449.7de28ba6.akpm@osdl.org> <Pine.LNX.4.44.0308260233550.20822-100000@devserv.devel.redhat.com> <20030826000218.2ceaea1d.akpm@osdl.org> <1061884611.2982.4.camel@laptop.fenrus.com> <20030826080759.GK13390@actcom.co.il> <20030826103833.GX1715@holomorphy.com> <20030826034458.35c54fbf.akpm@osdl.org> <20030826104535.GR4306@holomorphy.com> <20030826102931.28ecb5aa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826102931.28ecb5aa.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>  Then it sounds relatively easy to localize the search structure (if you
>>  care to do so),

On Tue, Aug 26, 2003 at 10:29:31AM -0700, Andrew Morton wrote:
> The "group of all processes which could potentially (or really do) share a
> chunk of anon memory" thing sounds tricky.

Not really; it's just a random data structure with very low odds of
proliferating. Hugh did it once (for anobjrmap) and I rearranged and/or
rewrote it to suit my preferences (I think I RCU'd the lock in it or
some ridiculous nonsense on that order).


William Lee Irwin III <wli@holomorphy.com> wrote:
>> apart from a policy decision about what on earth to do
>>  about waiters on truncated futexes.

On Tue, Aug 26, 2003 at 10:29:31AM -0700, Andrew Morton wrote:
> erk, screwed.

Well, the decision is essentially arbitrary, it just has to be made
(and by definition some decision is being made regardless of what the
implementation does or fails to do). 


-- wli
