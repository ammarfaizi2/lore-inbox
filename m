Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWBGRaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWBGRaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWBGRaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:30:12 -0500
Received: from ns2.suse.de ([195.135.220.15]:51586 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751107AbWBGRaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:30:06 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Tue, 7 Feb 2006 18:29:45 +0100
User-Agent: KMail/1.8.2
Cc: Ingo Molnar <mingo@elte.hu>, steiner@sgi.com, Paul Jackson <pj@sgi.com>,
       akpm@osdl.org, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602071523.20174.ak@suse.de> <Pine.LNX.4.62.0602070911050.24623@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602070911050.24623@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071829.46592.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 18:11, Christoph Lameter wrote:
> On Tue, 7 Feb 2006, Andi Kleen wrote:
> 
> > > are you sure this is not some older VM issue? 
> > 
> > Unless you implement page migration for all caches it's still there.
> > The only way to get rid of caches on a node currently is to throw them
> > away.  And refetching them from disk is quite costly.
> 
> The caches on a node are shrunk dynamically see the zone_reclaim 
> functionality introduced in 2.6.16-rc2.

Yes, they're thrown away which is wasteful. If they were spread
around in the first place that often wouldn't be needed.

-Andi

