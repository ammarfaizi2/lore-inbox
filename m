Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUHJLng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUHJLng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 07:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUHJLmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 07:42:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49356 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264396AbUHJLmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 07:42:01 -0400
Date: Tue, 10 Aug 2004 12:54:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kevin Fenzi <kevin-kernel@scrye.com>, Kevin Fenzi <kevin@scrye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pmdisk/swusp1 (merged) with 2.6.8-rc2-mm1
Message-ID: <20040810105445.GA467@openzaurus.ucw.cz>
References: <20040728185346.45CE54189@voldemort.scrye.com> <20040728201130.8B529D208C@voldemort.scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728201130.8B529D208C@voldemort.scrye.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> To followup on myself here, this can be set with: 
> 
> echo "shutdown" > /sys/power/disk
> 
> to tell it to use OS shutdown instead of firmware mode letting the
> bios handle things. 
> 
> Using that, I get a suspend to happen ok, but on resume I get a kernel
> panic. ;( 
> 
> Pavel/Patrick: Does your current implementation handle himem and/or
> preempt? 
> 
> suspend2 handles both, so I had them enabled in my config, but I
> wonder if that isn't the issue. The panic is in memory allocation it
> seems like. 
> 
> I can re-compile with both those off. 

There was bug in himem support, it is now fixed.
Preempt still leads to ugly warning; I'll eventually fix it.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

