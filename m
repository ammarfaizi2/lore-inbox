Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270391AbTGRWsU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270393AbTGRWsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:48:20 -0400
Received: from holomorphy.com ([66.224.33.161]:16009 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270391AbTGRWsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:48:17 -0400
Date: Fri, 18 Jul 2003 16:04:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030718230431.GQ15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20030717102857.GA1855@dualathlon.random> <20030718191853.A11052@infradead.org> <20030718222750.GL3928@dualathlon.random> <20030718224824.GP15452@holomorphy.com> <20030718225328.GQ3928@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718225328.GQ3928@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 12:53:28AM +0200, Andrea Arcangeli wrote:
> I tend to think the creation/destruction will be the most noticeable
> performance difference in practice. allocating 42G in a single block
> will take a bit of time ;). I'm not necessairly worse or unacceptable,
> but it's different. And I feel I've to retain the bigpages= API (as an
> API not as in implementation) anyways. Furthmore I'm unsure if hugtlbfs
> is relaxed like the shm-largpeage patch is, I mean, it should be
> possible to mmap the stuff with 4k granularty too, or stuff could break
> due that change of API too.

I've just not gotten feedback about creation and destruction; I get the
impression it's an uncommon operation.

The alignment etc. considerations are bits I probably can't get merged. =(

Most of the work I did was trying to get the preexisting semantics into
more standard-looking API's, e.g. vfs ops and standard-ish sysv shm.


-- wli
