Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263608AbTHZKo1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 06:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTHZKo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 06:44:27 -0400
Received: from holomorphy.com ([66.224.33.161]:42926 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263608AbTHZKo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 06:44:26 -0400
Date: Tue, 26 Aug 2003 03:45:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mulix@mulix.org, arjanv@redhat.com, mingo@redhat.com,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-ID: <20030826104535.GR4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, mulix@mulix.org, arjanv@redhat.com,
	mingo@redhat.com, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <20030825231449.7de28ba6.akpm@osdl.org> <Pine.LNX.4.44.0308260233550.20822-100000@devserv.devel.redhat.com> <20030826000218.2ceaea1d.akpm@osdl.org> <1061884611.2982.4.camel@laptop.fenrus.com> <20030826080759.GK13390@actcom.co.il> <20030826103833.GX1715@holomorphy.com> <20030826034458.35c54fbf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826034458.35c54fbf.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> except you have the usual intractable disaster
>>  whenever file-backed pages are anonymized via truncate().

On Tue, Aug 26, 2003 at 03:44:58AM -0700, Andrew Morton wrote:
> They only arose due to races between major faults and truncate.
> That got fixed.

Then it sounds relatively easy to localize the search structure (if you
care to do so), apart from a policy decision about what on earth to do
about waiters on truncated futexes.


-- wli
