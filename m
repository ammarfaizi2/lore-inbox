Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265945AbUFDSxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265945AbUFDSxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265942AbUFDSxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:53:35 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:12843 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265940AbUFDSxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:53:19 -0400
Date: Fri, 4 Jun 2004 12:01:46 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040604120146.4d28116a.pj@sgi.com>
In-Reply-To: <20040604175255.GD21007@holomorphy.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604090314.56d64f4d.pj@sgi.com>
	<20040604165601.GC21007@holomorphy.com>
	<20040604102946.1d501953.pj@sgi.com>
	<20040604175255.GD21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> +void bitmap_to_u32_array(u32 *dst, unsigned long *src, int nwords)

Good.

Assuming that you're signing up to push this baby along ...

Would it be better to remove the ENDIAN specific ifdefs from
lib/bitmap.c, and instead add something like the BIT32X() macro I
described earlier on this thread, in an aside to Mikael Pettersson?
If that macro were defined right in the ./linux/byteorder/*_endian.h
files, then endian neutral code could be put in lib/bitmap.c, and
endian aware code kept in the endian.h files.

Could you extend the cpumask_t API with a corresponding routine?

Mikael - does William's routine look like the makings of something
that fits your needs?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
