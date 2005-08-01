Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVHAGYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVHAGYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 02:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVHAGYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 02:24:23 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:11211
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S262339AbVHAGYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 02:24:21 -0400
Date: Mon, 1 Aug 2005 02:23:22 -0400
From: Sonny Rao <sonny@burdell.org>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, akpm@osdl.org, anton@samba.org,
       Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POWER 4 fails to boot with NUMA
Message-ID: <20050801062322.GA32415@kevlar.burdell.org>
References: <17133.45774.226079.790875@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17133.45774.226079.790875@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 12:27:42AM -0500, Paul Mackerras wrote:
> From: Mike Kravetz <kravetz@us.ibm.com>
> 
> If CONFIG_NUMA is set, some POWER 4 systems will fail to boot.  This is
> because of special processing needed to handle invalid node IDs (0xffff)
> on POWER 4.  My previous patch to handle memory 'holes' within nodes
> forgot to add this special case for POWER 4 in one place.
> 
> In reality, I'm not sure that configuring the kernel for NUMA on POWER 4
> makes much sense.  Are there POWER 4 based systems with NUMA characteristics
> that are presented by the firmware?  But, distros want one kernel for all
> systems so NUMA is on by default in their kernels.  The patch handles those
> cases.

IIRC, In SMP mode the NUMA topology is exported.  I've tried this on a
p690 and it worked correctly on older kernels (2.6.10 or 2.6.11) 

I also noticed a nice speedup on a few things compared to LPAR mode :-)

Sonny
