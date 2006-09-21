Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWIUO2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWIUO2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 10:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWIUO2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 10:28:17 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:49296 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750832AbWIUO2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 10:28:16 -0400
Date: Thu, 21 Sep 2006 08:27:34 -0600
From: Ray Lehtiniemi <rayl@shawcable.com>
Subject: Re: [ANNOUNCE] headergraphs - kernel header dependency visualizer
In-reply-to: <20060921064007.GA32653@uranus.ravnborg.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Message-id: <200609210827.34925.rayl@shawcable.com>
Organization: Home
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200609201217.06926.rayl@shawcable.com>
 <Pine.LNX.4.61.0609210810210.29240@yvahk01.tjqt.qr>
 <20060921064007.GA32653@uranus.ravnborg.org>
User-Agent: KMail/1.8.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 September 2006 00:40, Sam Ravnborg wrote:

> Reminds me...
> Arnaldo (acme) made a few simple scripts that was based on dot.
> They are at his home directory at kernel.org.

yah, the very first commit in my tree is an import of those scripts for 
reference purposes :-)


> Care to take at look at these to see if there is something to be learned.
> One good feature was that each level had a different color,
> and I recall the graphs was more dense with less (confusing?) info.

those graphs contain _much_ less information.

the primary complexity reduction mechanism in hviz appears to be that it adds 
the current file to the done list immediately before it starts the 
breadth-first search of the children.  this eliminates the possibility of 
back edges to previously seen headers, which is why those graphs flow so 
nicely from left to right.  unfortunately, it also discards most of the 
dependency information.

my goal was to retain and present information from _all_ edges in the graph, 
not just those which lead to new children.  even for relatively small 
hierarchies, these graphs generally wind up looking like a big ball of yarn, 
which is where all the confusing colors and numbers come into play.  they are 
the distilled remnants of all the edges that have been pruned.  only a select 
few edges remain to tie the whole thing together.


ray

