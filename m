Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVBSUun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVBSUun (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 15:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVBSUun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 15:50:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7350 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261803AbVBSUui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 15:50:38 -0500
Date: Sat, 19 Feb 2005 10:50:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] Dynamically allocated pageflags.
Message-ID: <20050219095025.GA475@openzaurus.ucw.cz>
References: <1108780994.4077.63.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108780994.4077.63.camel@desktop.cunningham.myip.net.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In Suspend2, I need the functional equivalent of pageflags, but don't
> need them when Suspend isn't running. One of the outcomes of the last
> submission of Suspend2 for review was that I changed the format in which
> that data is stored, creating something I call dynamically allocated
> pageflags.
> 
> It's a simple idea: we tie together a bunch of order zero allocated
> pages using a kmalloc'd list of poiinters to those pages, and store the

Will not using linklist for this make some algorithms O(n^2), hidden in the
macros so that user does not realize it?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

