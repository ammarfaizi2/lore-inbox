Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265733AbUFDL2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265733AbUFDL2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 07:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUFDL2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 07:28:08 -0400
Received: from holomorphy.com ([207.189.100.168]:11173 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265733AbUFDL2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 07:28:05 -0400
Date: Fri, 4 Jun 2004 04:27:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Paul Jackson <pj@sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040604112744.GZ21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, Paul Jackson <pj@sgi.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
	ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
	joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
	Simon.Derr@bull.net
References: <20040603094339.03ddfd42.pj@sgi.com> <20040603101010.4b15734a.pj@sgi.com> <1086313667.29381.897.camel@bach> <40BFD839.7060101@yahoo.com.au> <20040603221854.25d80f5a.pj@sgi.com> <16576.16748.771295.988065@alkaid.it.uu.se> <20040604093712.GU21007@holomorphy.com> <16576.17673.548349.36588@alkaid.it.uu.se> <20040604095929.GX21007@holomorphy.com> <16576.23059.490262.610771@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16576.23059.490262.610771@alkaid.it.uu.se>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>> cpumask_scnprintf() is correct to all appearances... testcase please.

On Fri, Jun 04, 2004 at 01:16:35PM +0200, Mikael Pettersson wrote:
> How large buf does it need? I don't see any spec for that in 2.6.6.
> Second, let's just say that while some kernel people think that
> converting stuff to ASCII is "neat", I'm not one of them. It's
> just a waste of time and space, for both kernel and user-space.
> I'd rather do a for-each-CPU loop which strictly keeps to cpumask_t
> operations than take a detour via ASCII.

If you care to export an architecture-neutral and/or 32/64 -bit
compatible binary representation of a bitmap, please provide the
implementation in lib/bitmap.c; I'm relatively agnostic on the ASCII
vs. whatever issue. Others may not be...

The cpu count for cpumask_t should be visible to userspace as the
dreaded sysconf(_SC_NPROCESSORS_CONF)...  don't ask how this is
implemented, you don't want to know.

Thanks.

-- wli
