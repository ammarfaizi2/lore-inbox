Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWAVWOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWAVWOV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 17:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWAVWOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 17:14:21 -0500
Received: from cantor2.suse.de ([195.135.220.15]:58601 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751333AbWAVWOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 17:14:20 -0500
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [patch] Fix the node cpumask of a cpu going down
Date: Sun, 22 Jan 2006 22:21:55 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>,
       discuss@x86-64.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>, tony.luck@intel.com
References: <20060121015633.GD3573@localhost.localdomain>
In-Reply-To: <20060121015633.GD3573@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601222221.56587.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 January 2006 02:56, Ravikiran G Thirumalai wrote:
> Currently, x86_64 and ia64 arches do not clear the corresponding bits 
> in the node's cpumask when a cpu goes down or cpu bring up is cancelled.  
> This is buggy since there are pieces of common code where the cpumask is
> checked in the cpu down code path to decide on things (like in  the slab
> down path).  PPC does the right thing, but x86_64 and ia64 don't (This 
> was the reason Sonny hit upon a slab bug during cpu offline on ppc and
> could not reproduce on other arches).  This patch fixes it for x86_64. 
> I won't attempt ia64 as I cannot test it.  

Added thanks.

-Andi

