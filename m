Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVCORqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVCORqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVCORpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:45:36 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:6785 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261543AbVCORnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:43:16 -0500
Date: Tue, 15 Mar 2005 11:43:10 -0600
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Hollis Blanchard <hollis@penguinppc.org>, akpm@osdl.org,
       linuxppc64-dev@ozlabs.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 iSeries: cleanup viopath
Message-ID: <20050315174310.GH498@austin.ibm.com>
References: <20050315143412.0c60690a.sfr@canb.auug.org.au> <0961a209ce72bb9f2a01b163aa6e6fbd@penguinppc.org> <20050316025339.318fc246.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316025339.318fc246.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 02:53:39AM +1100, Stephen Rothwell was heard to remark:
> On Tue, 15 Mar 2005 08:32:27 -0600 Hollis Blanchard <hollis@penguinppc.org> wrote:
> > 
> > Why not use a byte instead of a full int (reordering the members for 
> > alignment)?
> 
> Because "classical" boleans are ints.
> 
> Because I don't know the relative speed of accessing single byte variables.
> 
> Because it was easy.
> 
> Because we only allocate 32 of these structures.  Changing them really
> only adds four bytes per structure.  I guess using bytes and rearranging
> the structure could actually save 4 bytes per structure.

FWIW, keep in mind that a cache miss due to large structures not fitting
is a zillion times more expensive than byte-aligning in the cpu 
(even if byte operands had a cpu perf overhead, which I don't think 
they do on ppc).

> It really makes little difference, 

Yep. So my apologies for making you read this email.

--linas

