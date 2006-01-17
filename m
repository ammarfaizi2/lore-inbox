Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWAQH7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWAQH7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 02:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWAQH7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 02:59:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42684 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751287AbWAQH7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 02:59:04 -0500
Date: Tue, 17 Jan 2006 02:58:42 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mita@miraclelinux.com, Keith Owens <kaos@ocs.com.au>
Subject: Re: [patch 2.6.15-current] i386: multi-column stack backtraces
Message-ID: <20060117075841.GA5710@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org,
	mita@miraclelinux.com, Keith Owens <kaos@ocs.com.au>
References: <200601170126_MC3-1-B602-EFCB@compuserve.com> <20060116224234.5a7ca488.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116224234.5a7ca488.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 10:42:34PM -0800, Andrew Morton wrote:

 > Presumably this is going to bust ksymoops.
 
Do people actually still use ksymoops for 2.6 kernels ?

I resorted to it about 6 months ago for the first time in the
better part of 3 years, and it didn't even compile.
(I only wanted to disassemble a Code: line, addr resolution
 works for me [and most other distros afaik] with kksymoops now)

 > Also the various other custom
 > oops-parsers which people have written themselves.

Given we've extended the oops output in several different
ways without thought in the past, it seems a bit late.
We added printing of module list in the middle of the output.
We added various tainting flags over time.

What other tools parse oopses ? ksymoops is the only one I recall.

 > The patch is a desirable change (I do get seasick reading x86_64 traces,
 > but I'll get over it), but it'll cause various bits of downstream grief.

I'd be surprised if anyone noticed.

*shrug*, in an ideal world, no-one would ever see an oops anyway :-P
 
		Dave

