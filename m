Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264939AbUFGRHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264939AbUFGRHu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 13:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbUFGRHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 13:07:50 -0400
Received: from holomorphy.com ([207.189.100.168]:9656 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264939AbUFGRHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 13:07:48 -0400
Date: Mon, 7 Jun 2004 10:07:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: Paul Jackson <pj@sgi.com>, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       manfred@colorfullife.com, colpatch@us.ibm.com, Simon.Derr@bull.net
Subject: Re: fix up compat_sched_[get/set]affinity
Message-ID: <20040607170727.GE21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Joe Korty <joe.korty@ccur.com>, Paul Jackson <pj@sgi.com>,
	mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
	ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
	manfred@colorfullife.com, colpatch@us.ibm.com, Simon.Derr@bull.net
References: <40BFD839.7060101@yahoo.com.au> <20040603221854.25d80f5a.pj@sgi.com> <16576.16748.771295.988065@alkaid.it.uu.se> <20040604090314.56d64f4d.pj@sgi.com> <20040604165601.GC21007@holomorphy.com> <20040604170542.576b4243.pj@sgi.com> <20040605013139.GM21007@holomorphy.com> <20040605010444.6a384e6c.pj@sgi.com> <20040605082647.GQ21007@holomorphy.com> <20040607165445.GA22234@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040607165445.GA22234@tsunami.ccur.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 12:54:46PM -0400, Joe Korty wrote:
> Possible algorithms for the support routines needed by wli's code, above.
> Completely untested, hope to refine and test soon.

I had in mind:
#define cpus_to_u32_array(a,cpus)   bitmap_to_u32_array(a,cpus,sizeof(cpus))
#define cpus_from_u32_array(a,cpus) bitmap_from_u32_array(a,cpus,sizeof(cpus))

Non-issue since Mikael already has some tested/etc. code to drop into
lib/bitmap.c or wherever.


-- wli
