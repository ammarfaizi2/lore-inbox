Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTK1VJv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 16:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTK1VJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 16:09:51 -0500
Received: from holomorphy.com ([199.26.172.102]:62147 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263468AbTK1VJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 16:09:50 -0500
Date: Fri, 28 Nov 2003 13:09:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, kaos@melbourne.sgi.com, joe.korty@ccur.com,
       tony.luck@intel.com, linux-kernel@vger.kernel.org,
       David Mosberger-Tang <davidm@hpl.hp.com>,
       Christoph Hellwig <hch@infradead.org>, jbarnes@sgi.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] new /proc/irq cpumask format; consolidate cpumask display and input code
Message-ID: <20031128210931.GZ8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
	kaos@melbourne.sgi.com, joe.korty@ccur.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org,
	David Mosberger-Tang <davidm@hpl.hp.com>,
	Christoph Hellwig <hch@infradead.org>, jbarnes@sgi.com,
	Simon.Derr@bull.net
References: <20031118002647.GH22764@holomorphy.com> <2173.1069115651@kao2.melbourne.sgi.com> <20031118005637.GI22764@holomorphy.com> <20031128125428.46ec7606.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128125428.46ec7606.pj@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 12:54:28PM -0800, Paul Jackson wrote:
> I believe that Andrew Morton has accepted Bill's patch into
> his 2.6.0-test10-mm1 patch set as the "format_cpumask" patch.
> I hope that the following patch will replace Bill's patch.
> I look forward to Bill's feedback on this patch.
> The following patch carries Bill's work further:
>  1) It also consolidates the input side (write syscalls).
>  2) It adapts a new format, same on input and output.
>  3) The core routines work for any multi-word bitmask,
>     not just cpumasks.
>  4) The core routines avoid overrunning their output
>     buffers.

I like this a bit better than format_cpumask() since it's more
comprehensive. I don't believe you'll have a tough time selling
the format either, since it is easier to parse.


-- wli
