Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVJCUS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVJCUS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 16:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVJCUS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 16:18:56 -0400
Received: from [81.2.110.250] ([81.2.110.250]:18154 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932375AbVJCUS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 16:18:56 -0400
Subject: Re: AMD Geode GX/LX support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051003195531.GB30975@cosmic.amd.com>
References: <20051003174738.GC29264@cosmic.amd.com>
	 <1128366109.26992.27.camel@localhost.localdomain>
	 <20051003195531.GB30975@cosmic.amd.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 21:46:09 +0100
Message-Id: <1128372369.26992.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-03 at 13:55 -0600, Jordan Crouse wrote:
> As I mentioned in the previous e-mail, the GEODEGX1 define as it stands
> is incorrect - the cache line size should be 16 bytes for the GX1.  The 
> GX and LX share a newer core, so it stands, I think that they should have
> a different define.

What makes the cores different ? Cache line size ? If they share the
same kernel options and build then they don't need a new define, the
existing one just need generalising.
  
> I suppose that I should come with something more solid then a gut feeling, 
> though, substantial as my gut may be.

Indeed. With gcc 3.x I ended up with -m486 -falign-functions=0 and that
used to be the settings. I don't know who changed it to pentium-mmx in
the end but I objected to about four different patches that did this
over time and people still kept submitting them.


