Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUCWCNy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbUCWCNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:13:54 -0500
Received: from holomorphy.com ([207.189.100.168]:48274 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261931AbUCWCMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:12:36 -0500
Date: Mon, 22 Mar 2004 18:12:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-ID: <20040323021210.GX2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com, hch@infradead.org
References: <1079651064.8149.158.camel@arrakis> <20040318165957.592e49d3.pj@sgi.com> <1079659184.8149.355.camel@arrakis> <20040318175654.435b1639.pj@sgi.com> <1079737351.17841.51.camel@arrakis> <20040319165928.45107621.pj@sgi.com> <20040320031843.GY2045@holomorphy.com> <20040319220907.1e07d36f.pj@sgi.com> <20040320093614.GZ2045@holomorphy.com> <20040322155952.4d6f5035.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322155952.4d6f5035.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 03:59:52PM -0800, Paul Jackson wrote:
> Could you (Bill or any lurker) provide any specific examples of generic
> code where it is important to pass by value on some architectures, but
> by const reference on some other architectures?  Rather than distort the
> API in general for such cases, I'd prefer to consider more narrowly
> focused solutions that address such specific needs.  In general, I would
> hope to be able to arrive at a cpumask (or even more generic mask as
> multi-word bit mask) ADT that was always clear and explicit, using just
> traditional 'C' idioms, as to whether arguments were pass by value or
> reference, and which arguments were const reference or not-const.  If
> some arch's (say sparc64) have arch-specific code that explicitly passes
> a pointer to a cpumask, where similar code in some other arch passes by
> value, that's fine, and an appropriate arch-specific optimization.  The
> only challenges come in generic code for which arch's cannot agree on
> any one form for passing a particular mask.  Examples anyone ... ?

I don't have examples of such, no. The requirement was imposed on me for
basically the reason that what cpu-related API's preceded cpumask_t
compiled out to nops on UP and no indirection on small SMP. If you've
got such an implementation that compiles out to nops on UP etc., or can
get the requirement(s) dropped, I'm all ears.

-- wli
