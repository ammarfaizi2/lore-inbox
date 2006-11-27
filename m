Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758496AbWK0SDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758496AbWK0SDW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758497AbWK0SDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:03:22 -0500
Received: from ns2.suse.de ([195.135.220.15]:61607 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1758485AbWK0SDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:03:22 -0500
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [Patch3/4]: fake numa for x86_64 patches
Date: Mon, 27 Nov 2006 19:03:04 +0100
User-Agent: KMail/1.9.5
Cc: Mel Gorman <mel@csn.ul.ie>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>
References: <1164245687.29844.153.camel@galaxy.corp.google.com> <20061123090456.GD29738@bingen.suse.de> <1164650348.6619.12.camel@galaxy.corp.google.com>
In-Reply-To: <1164650348.6619.12.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611271903.04669.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 November 2006 18:59, Rohit Seth wrote:
> On Thu, 2006-11-23 at 10:04 +0100, Andi Kleen wrote:
> > On Wed, Nov 22, 2006 at 05:34:47PM -0800, Rohit Seth wrote:
> > > Fix the existing numa=fake so that ioholes are appropriately configured.
> > > Currently machines that have sizeable IO holes don't work with
> > > numa=fake>4.  This patch tries to equally partition the total available
> > > memory in equal size chunk.  The minimum size of the fake node is set to
> > > 32MB.
> > 
> > This patch seems to do far more than advertised in the change log? 
> > 
> > You're conflicting badly with Amul's numa hash function rewrite for example.
> > 
> 
> Both of these patches are mucking with hash function and
> populate_memnodemap.  I like Amul's approach of doing dynamic allocation
> of numa hash map so that it can support >64GB of memory space.  I will
> resend the patches on top of his patch (incorporating your other
> feedback).

FYI I dropped Amul's patch temporarily because it causes boot failures on 
some systems. But it will be likely readded once that problem is fixed.

-Andi

