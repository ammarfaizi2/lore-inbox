Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422645AbWBVC0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWBVC0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbWBVC0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:26:33 -0500
Received: from ozlabs.org ([203.10.76.45]:26318 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750843AbWBVC0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:26:31 -0500
Date: Wed, 22 Feb 2006 13:17:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IA64 non-contiguous memory space bugs
Message-ID: <20060222021714.GD23574@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"David S. Miller" <davem@davemloft.net>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060222001359.GA23574@localhost.localdomain> <20060221.163935.32626284.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221.163935.32626284.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 04:39:35PM -0800, David S. Miller wrote:
> From: David Gibson <david@gibson.dropbear.id.au>
> Date: Wed, 22 Feb 2006 11:13:59 +1100
> 
> > Quite some time ago, I found (by inspection) an ia64 specific bug
> > related to its non-contiguous user address space.  I've never done
> > anything about it, because I don't have an ia64 to test on - but
> > somebody should fix it.  Recently I've spotted another possible bug,
> > also by inspection - I don't know enough about ia64 to tell if it's a
> > real problem or not.
> 
> Good catch David, I'll need to add similar checks on sparc64 as
> we have a 64-bit virtual address space hole on several processors
> there.

Ok, that patch adds all the checks in generic code anyway, so all you
should need for sparc64 is an appropriate REGION_MAX() macro.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
