Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWJTPTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWJTPTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWJTPTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:19:35 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:30184 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932206AbWJTPTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:19:34 -0400
Subject: Re: kernel BUG in __cache_alloc_node at
	linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
To: Andy Whitcroft <apw@shadowen.org>
Cc: Christoph Lameter <clameter@sgi.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Mel Gorman <mel@csn.ul.ie>, Mike Kravetz <kravetz@us.ibm.com>
In-Reply-To: <4538DACC.5050605@shadowen.org>
References: <1161026409.31903.15.camel@farscape>
	 <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	 <1161031821.31903.28.camel@farscape>
	 <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	 <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	 <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	 <17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
	 <20061019163044.GB5819@krispykreme>
	 <Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
	 <17719.64246.555371.701194@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com>
	 <17720.30804.180390.197567@cargo.ozlabs.ibm.com>
	 <4538DACC.5050605@shadowen.org>
Content-Type: text/plain
Organization: IBM
Date: Fri, 20 Oct 2006 10:19:25 -0500
Message-Id: <1161357566.8946.62.camel@farscape>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-20-10 at 15:18 +0100, Andy Whitcroft wrote:
> Paul Mackerras wrote:
> > Christoph Lameter writes:
> > 

I got dropped off the CC list somewhere..  :-(     

if something is bouncing, let me know,.. otherwise please dont do
that.. 


> Mel Gorman and I have been poking at this from different ends.  Mel from
> the context of this thread and myself trying to fix a machine which was
> exhibiting on 32MB of ram in node 0 and the rest in node 1.
> 
> I remember that we used to have code to cope with this in the ppc64
> architecture, indeed I remember reviewing it all that time ago.  Looking
> at the current state of the tree it was removed in the two patches below
> in mainline:
> 	"[PATCH] Remove SPAN_OTHER_NODES config definition"
> 	"[PATCH] mm: remove arch independent NODES_SPAN_OTHER_NODES"
> 
> These commits:
> 	f62859bb6871c5e4a8e591c60befc8caaf54db8c
> 	a94b3ab7eab4edcc9b2cb474b188f774c331adf7
> 
> I'll follow up to this email with the reversion patch we used in
> testing.  It seems to sort this problem out at least, though now its
> blam'ing in ibmveth, so am retesting with yet another patch.  This patch
> reverts the two patches above and updates the commentry on the Kconfig
> entry.

I've got a couple LPARs that exhibit the problem, so can verify your
patch once I see it.. 

-Will


> 
> -apw

