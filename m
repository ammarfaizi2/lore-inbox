Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVD1Mzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVD1Mzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 08:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVD1Mzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 08:55:36 -0400
Received: from gate.in-addr.de ([212.8.193.158]:52181 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262101AbVD1MzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 08:55:22 -0400
Date: Thu, 28 Apr 2005 14:37:20 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@istop.com>
Cc: David Teigland <teigland@redhat.com>, Steven Dake <sdake@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050428123720.GQ21645@marowsky-bree.de>
References: <20050425165826.GB11938@redhat.com> <20050427030217.GA9963@redhat.com> <20050427134142.GZ4431@marowsky-bree.de> <200504272252.55525.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200504272252.55525.phillips@istop.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-27T22:52:55, Daniel Phillips <phillips@istop.com> wrote:

> > So we can't deliver it raw membership events. Noted.
> 
> Just to pick a nit: there is no way to be sure a membership event might not 
> still be on the way to the dead node, however the rest of the cluster knows 
> the node is dead and can ignore it, in theory.  (In practice, only (g)dlm and 
> gfs are well glued into the cman membership protocol, and other components, 
> e.g., cluster block devices and applications, need to be looked at with 
> squinty eyes.)

I'm sorry, I don't get what you are saying here. Could you please
clarify?

"Membership even on the way to the dead node"? ie, you mean that the
(now dead) node hasn't acknowledged a previous membership which still
included it, because it died inbetween? Well, sure, membership is never
certain at all; it's always in transition, essentially, because we can
only detect faults some time after the fact. 

(It'd be cool if we could mandate nodes to pre-announce failures by a
couple of seconds, alas I think that's a feature you'll only find in an
OSDL requirement document, rated as "prio 1" ;-)

I also don't understand what you're saying in the second part. How are
gdlm/gfs "well glued" into the CMAN membership protocol, and what are we
looking for when we turn our squinty eyes to applications...?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

