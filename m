Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751387AbWFEUFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWFEUFf (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWFEUFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:05:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23189 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751394AbWFEUFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:05:34 -0400
Date: Mon, 5 Jun 2006 13:05:02 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andy Whitcroft <apw@shadowen.org>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
        mbligh@google.com, linux-kernel@vger.kernel.org, ak@suse.de,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <44848DD2.7010506@shadowen.org>
Message-ID: <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org>
 <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org>
 <447E104B.6040007@mbligh.org> <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org> <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
 <44848DD2.7010506@shadowen.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006, Andy Whitcroft wrote:

> 
> Adding 65528k swap on ./swapfile01.  Priority:-2 extents:116 across:360044k
> Adding 65528k swap on ./swapfile01.  Priority:-3 extents:104 across:569492k
> Adding 65528k swap on ./swapfile01.  Priority:-4 extents:172 across:520952k
> Unable to find swap-space signature
> Adding 32k swap on swapfile02.  Priority:-5 extents:2 across:60k
> Adding 32k swap on swapfile03.  Priority:-6 extents:1 across:32k
> Adding 32k swap on swapfile04.  Priority:-7 extents:1 across:32k
> Adding 32k swap on swapfile05.  Priority:-8 extents:3 across:44k
> Adding 32k swap on swapfile06.  Priority:-9 extents:1 across:32k
> Adding 32k swap on swapfile07.  Priority:-10 extents:1 across:32k
> Adding 32k swap on swapfile08.  Priority:-11 extents:1 across:32k
> Adding 32k swap on swapfile09.  Priority:-12 extents:1 across:32k
> Adding 32k swap on swapfile10.  Priority:-13 extents:1 across:32k
> Adding 32k swap on swapfile11.  Priority:-14 extents:1 across:32k
> Adding 32k swap on swapfile12.  Priority:-15 extents:1 across:32k
> Adding 32k swap on swapfile13.  Priority:-16 extents:1 across:32k
> Adding 32k swap on swapfile14.  Priority:-17 extents:1 across:32k
> Adding 32k swap on swapfile15.  Priority:-18 extents:1 across:32k
> Adding 32k swap on swapfile16.  Priority:-19 extents:1 across:32k
> Adding 32k swap on swapfile17.  Priority:-20 extents:1 across:32k
> Adding 32k swap on swapfile18.  Priority:-21 extents:1 across:32k
> Adding 32k swap on swapfile19.  Priority:-22 extents:1 across:32k
> Adding 32k swap on swapfile20.  Priority:-23 extents:1 across:32k
> Adding 32k swap on swapfile21.  Priority:-24 extents:1 across:32k
> Adding 32k swap on swapfile22.  Priority:-25 extents:1 across:32k
> Adding 32k swap on swapfile23.  Priority:-26 extents:1 across:32k
> Adding 32k swap on swapfile24.  Priority:-27 extents:1 across:32k
> Adding 32k swap on swapfile25.  Priority:-28 extents:1 across:32k
> Adding 32k swap on swapfile26.  Priority:-29 extents:1 across:32k
> Adding 32k swap on swapfile27.  Priority:-30 extents:1 across:32k
> Adding 32k swap on swapfile28.  Priority:-31 extents:1 across:32k
> Adding 32k swap on swapfile29.  Priority:-32 extents:1 across:32k
> Adding 32k swap on swapfile30.  Priority:-33 extents:1 across:32k
> Adding 32k swap on swapfile31.  Priority:-34 extents:1 across:32k
> Adding 32k swap on swapfile32.  Priority:-35 extents:1 across:32k


That should not work at all. It should bomb out at 30 swap files with page 
migration on.

