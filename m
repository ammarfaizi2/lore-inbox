Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbUFJTwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUFJTwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUFJTv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:51:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47819 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262850AbUFJTvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:51:21 -0400
Date: Thu, 10 Jun 2004 14:03:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] ppc64 gives up too quickly on hotplugged cpu
Message-ID: <20040610120350.GC4507@openzaurus.ucw.cz>
References: <40BE5B6E.7060109@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BE5B6E.7060109@austin.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On some systems it can take a hotplugged cpu much longer to come up 
> than it would at boot.  If the cpu comes up after we've given up on 
> it, it tends to die in its first attempt to kmem_cache_alloc 
> (uninitialized percpu data, I imagine).

Should not CPU check if system given up on it, and go to infinite
loop if it did to prevent data corruption?

Ouch and please inline patches.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

