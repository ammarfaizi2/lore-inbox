Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbUCWCKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUCWCKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:10:42 -0500
Received: from holomorphy.com ([207.189.100.168]:46482 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261983AbUCWCKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:10:16 -0500
Date: Mon, 22 Mar 2004 18:10:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-ID: <20040323021013.GW2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com, hch@infradead.org
References: <1079651064.8149.158.camel@arrakis> <20040318165957.592e49d3.pj@sgi.com> <1079659184.8149.355.camel@arrakis> <20040318175654.435b1639.pj@sgi.com> <1079737351.17841.51.camel@arrakis> <20040319165928.45107621.pj@sgi.com> <20040320031843.GY2045@holomorphy.com> <20040319220907.1e07d36f.pj@sgi.com> <20040320093614.GZ2045@holomorphy.com> <20040322172134.180933b3.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322172134.180933b3.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 05:21:34PM -0800, Paul Jackson wrote:
> Providing the additional mask "instructions" shouldn't create any quagmire.
> It's the using of them that is intrusive.
> Initially, some intrusive work, such as you (Bill) did was needed to get
> masks implanted.  But now it should be appropriate to simply provide the
> alternative calls that can make certain code sequences more efficient,
> and then if someone complains that their old code sequence is too slow
> or uses too much stack, we can recommend alternative code sequences that
> will work better for them.
> Passing the buck, division of labour and all that ...

Higher-level constructs that improve runtime efficiency may also be
good cleanups that can sometimes fix bugs and/or generally consolidate
code. e.g. cpus_subset(x, y). I think those kinds of things should be
perfectly mergeable.


-- wli
