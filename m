Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUFJQOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUFJQOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 12:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUFJQOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 12:14:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:11913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261937AbUFJQOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 12:14:17 -0400
Date: Thu, 10 Jun 2004 09:11:15 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: pj@sgi.com, mikpe@csd.uu.se, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.7-rc3-mm1] perfctr cpumask cleanup
Message-Id: <20040610091115.13f78008.rddunlap@osdl.org>
In-Reply-To: <20040610160350.GB1444@holomorphy.com>
References: <200406092050.i59KoWoa000621@alkaid.it.uu.se>
	<20040609154750.241df741.pj@sgi.com>
	<16584.9947.222378.506457@alkaid.it.uu.se>
	<20040610090157.04fa62ee.pj@sgi.com>
	<20040610160350.GB1444@holomorphy.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2004 09:03:50 -0700 William Lee Irwin III wrote:

| Mikael wrote:
| >> Doesn't work because cpus_andnot() requires all three parameters
| >> to be lvalues. ... CPU_MASK_NONE ...
| 
| On Thu, Jun 10, 2004 at 09:01:57AM -0700, Paul Jackson wrote:
| > I think your other fix (also done by Bill Irwin), make the above possible:
| >  #define CPU_MASK_NONE							\
| > -{ {									\
| > +((cpumask_t) { {							\
| 
| I've posted this at least twice, I think once in isolation for some
| driver (MSI?) and once as part of the Alpha fixes.
| 
| Please get some cross-compilers together so we don't have every non-x86
| arch exploding at once. Alpha vs. cpu_possible_map was horrendous.

or submit such patches to OSDL PLM.  PLM will apply the patch
(to whatever base you say, although you may have to supply the
"base" also; linus and -mm bases are already there)
and then try to cross-compile it on ia32, ia64, ppc32, ppc64, alpha,
sparc32, sparc64, and x86_64.

E.g., here's the results of 2.6.7-rc3-bk3:
https://www.osdl.org/plm-cgi/plm?module=patch_info&patch_id=3010

--
~Randy
