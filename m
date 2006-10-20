Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992638AbWJTO7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992638AbWJTO7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 10:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWJTO7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 10:59:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:18573 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932260AbWJTO7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 10:59:01 -0400
Date: Fri, 20 Oct 2006 07:59:45 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       Anton Blanchard <anton@samba.org>, akpm@osdl.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Mel Gorman <mel@csn.ul.ie>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
Message-ID: <20061020145945.GA5085@monkey.ibm.com>
References: <17718.39522.456361.987639@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com> <17719.1849.245776.4501@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com> <20061019163044.GB5819@krispykreme> <Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com> <17719.64246.555371.701194@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com> <17720.30804.180390.197567@cargo.ozlabs.ibm.com> <4538DACC.5050605@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4538DACC.5050605@shadowen.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 03:18:52PM +0100, Andy Whitcroft wrote:
> I remember that we used to have code to cope with this in the ppc64
> architecture, indeed I remember reviewing it all that time ago.  Looking
> at the current state of the tree it was removed in the two patches below
> in mainline:
> 	"[PATCH] Remove SPAN_OTHER_NODES config definition"
> 	"[PATCH] mm: remove arch independent NODES_SPAN_OTHER_NODES"

That was me.  Seem to remember some discussion that these were only
needed for DISCONTIGMEM, so I removed them when the DISCONTIGMEM option
for power went away.  But, that is clearly NOT the case.  Appears that
SPARSEMEM and the old slab code covered up the issue.  Sorry about that.

Thanks!
-- 
Mike
