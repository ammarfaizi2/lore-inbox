Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933320AbWKWJFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933320AbWKWJFN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933299AbWKWJFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:05:13 -0500
Received: from mail.suse.de ([195.135.220.2]:12944 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933321AbWKWJE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:04:59 -0500
Date: Thu, 23 Nov 2006 10:04:56 +0100
From: Andi Kleen <ak@suse.de>
To: Rohit Seth <rohitseth@google.com>
Cc: Andi Kleen <ak@suse.de>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>
Subject: Re: [Patch3/4]: fake numa for x86_64 patches
Message-ID: <20061123090456.GD29738@bingen.suse.de>
References: <1164245687.29844.153.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164245687.29844.153.camel@galaxy.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 05:34:47PM -0800, Rohit Seth wrote:
> Fix the existing numa=fake so that ioholes are appropriately configured.
> Currently machines that have sizeable IO holes don't work with
> numa=fake>4.  This patch tries to equally partition the total available
> memory in equal size chunk.  The minimum size of the fake node is set to
> 32MB.

This patch seems to do far more than advertised in the change log? 

You're conflicting badly with Amul's numa hash function rewrite for example.

I don't see why you need to change that much code for this relatively
simple change anyways.

-Andi
