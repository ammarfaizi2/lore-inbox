Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUDHAOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 20:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUDHAOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 20:14:52 -0400
Received: from ns.suse.de ([195.135.220.2]:11444 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261400AbUDHAOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 20:14:50 -0400
Date: Thu, 8 Apr 2004 02:14:48 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mbligh@aracnet.com, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-Id: <20040408021448.0dbaa80f.ak@suse.de>
In-Reply-To: <20040407165639.2198b215.akpm@osdl.org>
References: <1081373058.9061.16.camel@arrakis>
	<20040407145130.4b1bdf3e.akpm@osdl.org>
	<5840000.1081377504@flay>
	<20040408003809.01fc979e.ak@suse.de>
	<20040407155225.14936e8a.akpm@osdl.org>
	<20040408013522.294f0322.ak@suse.de>
	<20040407165639.2198b215.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004 16:56:39 -0700
Andrew Morton <akpm@osdl.org> wrote:
 
> If you _do_ use the feature, what is the overhead?  12 bytes for each and
> every vma?  Or just for the vma's which have a non-default policy?

Just for VMAs with a non default policy. Default policy is always NULL

> Your patch takes the CONFIG_NUMA vma from 64 bytes to 68.  It would be nice
> to pull those 4 bytes back somehow.

Eliminate the RB color field or use rb_next() instead of vm_next. First 
alternative is cheaper.

-Andi
