Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUESWJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUESWJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 18:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbUESWJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 18:09:32 -0400
Received: from thunk.org ([140.239.227.29]:19586 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264635AbUESWJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 18:09:29 -0400
Date: Wed, 19 May 2004 18:08:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Mark Gross <mgross@linux.jf.intel.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
Message-ID: <20040519220819.GA5698@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Tim Bird <tim.bird@am.sony.com>,
	Christoph Hellwig <hch@infradead.org>,
	Mark Gross <mgross@linux.jf.intel.com>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <40A90D00.7000005@am.sony.com> <20040517201910.A1932@infradead.org> <200405171342.49891.mgross@linux.intel.com> <20040518074854.A7348@infradead.org> <40ABB5E2.3040908@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ABB5E2.3040908@am.sony.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 12:30:42PM -0700, Tim Bird wrote:
> What on earth are you talking about?  CELF includes members who
> sell things, but the specification specifically discounts any
> claims of conformance.  

Perhaps not, but it uses the language of conformance:

	The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD,
	SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be
	interpreted as described in [RFC2119]. The term "CELF-conforming" is
	used to refer to technology, platforms, or systems that conform to the
	CELF specifications or standards contained in this document.

And in section 3.8.3, it states:

	The Linux kernel SHALL support a configuration to provide the
	following described timing API.

Oh, it SHALL provide such a API, shall it?  Says who?  Does the CELF
really think to dictate to the kernel developers that they SHALL use a
particular API?  Language such as this can really rub people the wrong
way, especially when they don't have the authority to make such
demands on the kernel development community.

Something a lot more informal, such as, "look we really could use the
following facility".  Here's a suggested API; we're not wedded to it,
but this is why we need the following functionality.  Currently, the
rationale/justification is currently completely missing for section
3.8.2 for this feature.  We are just told that we MUST and SHALL
provide this feature, for no good stated reason:

A) The configuration option to enable this feature MUST be called
CONFIG_FAST_TIMESTAMPS

B) When CONFIG_FAST_TIMESTAMPS is enabled, the kernel SHALL provide
the following 2 routines:

      2.1 void store_timestamp(timestamp_t *t)

      2.2 void timestamp_to_timeval(timestamp_t *t, struct timeval *tv) 

etc.

I think the reason why some folks might suspect that consortia such as
CELF might be bilking their members is because such a document might
easily be construed by a pointed-haired-boss that CELF might actually
have the authority to dictate demands to the Linux Kernel development
community.

Would it not be more honest to admit freely that each one of these
wishlist items involve a negotiation process, and the ultimate API
might be different --- in some cases perhaps more restricted, or in
other cases, in collaboration with the kernel development community,
it might be that a more powerful, more general API that solves several
problems might be devised?

In any case, having discussion in closed forums can very often be a
waste of time, since the discussions will then have to be replicated
in the open forums --- in the case of linux kernel, in LKML --- before
the discussions will actually do any good.  I suppose for less
confident folks, they could view CELF as a practice forum, or perhaps
it is a way of anonymizing requests from people who don't want to
admit that they are using Linux, or who don't want to admit they need
a particular request.  They should be aware, however, that anonymous
requests often get less weight than specific requests that explain
specifically why a particular feature is needed.

And definitely, an approach which is more collegial and less
dictorial, which doesn't explain why the kernel developers MUST and
SHALL do is much more likely to succeed.  You catch few flies with
vinegar.

Just a few friendly suggestions....

							- Ted
