Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758499AbWK0SAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758499AbWK0SAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758501AbWK0SAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:00:12 -0500
Received: from smtp-out.google.com ([216.239.45.12]:13019 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1758499AbWK0SAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:00:10 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=C8WrPakn+2xctIHxBx4mJ4Xxr37AdBzUbQeJBpLKfTSKQtJB8efQ0ZbLDDSNgwPXX
	4mh0N8FtYqJ5ucaLz4leQ==
Subject: Re: [Patch3/4]: fake numa for x86_64 patches
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Mel Gorman <mel@csn.ul.ie>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>
In-Reply-To: <20061123090456.GD29738@bingen.suse.de>
References: <1164245687.29844.153.camel@galaxy.corp.google.com>
	 <20061123090456.GD29738@bingen.suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 27 Nov 2006 09:59:08 -0800
Message-Id: <1164650348.6619.12.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 10:04 +0100, Andi Kleen wrote:
> On Wed, Nov 22, 2006 at 05:34:47PM -0800, Rohit Seth wrote:
> > Fix the existing numa=fake so that ioholes are appropriately configured.
> > Currently machines that have sizeable IO holes don't work with
> > numa=fake>4.  This patch tries to equally partition the total available
> > memory in equal size chunk.  The minimum size of the fake node is set to
> > 32MB.
> 
> This patch seems to do far more than advertised in the change log? 
> 
> You're conflicting badly with Amul's numa hash function rewrite for example.
> 

Both of these patches are mucking with hash function and
populate_memnodemap.  I like Amul's approach of doing dynamic allocation
of numa hash map so that it can support >64GB of memory space.  I will
resend the patches on top of his patch (incorporating your other
feedback).

-rohit




