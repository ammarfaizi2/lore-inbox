Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVEQDkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVEQDkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 23:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVEQDkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 23:40:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:25767 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261310AbVEQDke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 23:40:34 -0400
Date: Tue, 17 May 2005 05:40:28 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Lameter <christoph@lameter.com>,
       randy_dunlap <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org, ak@suse.de
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
Message-ID: <20050517034028.GC9699@wotan.suse.de>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw> <20050516150907.6fde04d3.akpm@osdl.org> <Pine.LNX.4.62.0505161934220.25315@graphe.net> <20050516194651.1debabfd.rdunlap@xenotime.net> <Pine.LNX.4.62.0505161954470.25647@graphe.net> <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	choice
> 		prompt "Timer frequency"
> 		default HZ_250
> 
> 	config HZ_100
> 		bool "100 Hz"
> 
> 	confic HZ_250
> 		bool "250 Hz"
> 
> 	config HZ_1000
> 		bool "1000 Hz"

I would add a 

	config HZ_10 if EMBEDDED 
		bool "10 Hz" 

that is useful for compute servers (although it will violate the TCP
specification). EMBEDDED would ensure only people who know what they're
doing set it.

-Andi

