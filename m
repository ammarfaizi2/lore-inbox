Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUFJQEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUFJQEB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 12:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUFJQEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 12:04:01 -0400
Received: from holomorphy.com ([207.189.100.168]:40587 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261682AbUFJQEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 12:04:00 -0400
Date: Thu, 10 Jun 2004 09:03:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.7-rc3-mm1] perfctr cpumask cleanup
Message-ID: <20040610160350.GB1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, Mikael Pettersson <mikpe@csd.uu.se>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200406092050.i59KoWoa000621@alkaid.it.uu.se> <20040609154750.241df741.pj@sgi.com> <16584.9947.222378.506457@alkaid.it.uu.se> <20040610090157.04fa62ee.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610090157.04fa62ee.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael wrote:
>> Doesn't work because cpus_andnot() requires all three parameters
>> to be lvalues. ... CPU_MASK_NONE ...

On Thu, Jun 10, 2004 at 09:01:57AM -0700, Paul Jackson wrote:
> I think your other fix (also done by Bill Irwin), make the above possible:
>  #define CPU_MASK_NONE							\
> -{ {									\
> +((cpumask_t) { {							\

I've posted this at least twice, I think once in isolation for some
driver (MSI?) and once as part of the Alpha fixes.

Please get some cross-compilers together so we don't have every non-x86
arch exploding at once. Alpha vs. cpu_possible_map was horrendous.


-- wli
