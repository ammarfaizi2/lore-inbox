Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbUCXCEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 21:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbUCXCEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 21:04:22 -0500
Received: from holomorphy.com ([207.189.100.168]:12418 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262976AbUCXCEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 21:04:21 -0500
Date: Tue, 23 Mar 2004 18:03:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH] nodemask_t x86_64 changes [5/7]
Message-ID: <20040324020357.GC791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com
References: <1079651082.8149.175.camel@arrakis> <20040322230850.1d8f26dc.pj@sgi.com> <20040323101323.GD2045@holomorphy.com> <20040323133650.2044fd8f.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323133650.2044fd8f.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 01:36:50PM -0800, Paul Jackson wrote:
> My current understanding of the complement op is that it is broken for
> non-word multiple sizes.  There's a good chance I'm still be confused on
> this matter.
> It might make sense to redo this particular bit of offline logic not by
> using *_complement, but rather by looping over all nodes, and only
> acting if not online, thus avoiding the *_complement() operator for now.
> I have not thought through the performance implications of such a code
> inversion, however.

If someone's not treating the leftover bits as "don't cares", then
there's a bug. Or so goes the current convention. I think originally, I
had avoided touching the bits at the end, then the "don't cares"
suggestion was incorporated). This doesn't appear to be problematic on
smaller systems. Any idea where this bogon might be?


-- wli
