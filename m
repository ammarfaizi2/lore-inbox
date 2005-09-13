Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbVIMWWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVIMWWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVIMWWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:22:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31649 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932532AbVIMWWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:22:11 -0400
Date: Tue, 13 Sep 2005 15:21:53 -0700
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050913152153.2013587b.pj@sgi.com>
In-Reply-To: <20050913070442.GA5629@elte.hu>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
	<20050912043943.5795d8f8.akpm@osdl.org>
	<Pine.LNX.4.58.0509120732060.3242@g5.osdl.org>
	<20050913070442.GA5629@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, confirming Linus's suggestion:
> btw., this is how the -rt tree implements (read-)nesting for rwsems and 
> rwlocks. The more sharing and embedding of types and primitives, the 
> more compact the whole code becomes, and the easier it is to change 
> fundamental properties.

I completely agree.

Such is the art of fine programming.

My basic concern was that Linus was trying to put lipstick
on a pig.

If one gets the underlying structure right, then one should
package it in the best way one can, such as you and Linus
describe.

If one has a hack, better to leave it naked to the world,
with a minimum of artiface.

That way it attracts attention from those who know better
and are repulsed.  And that way, when something better
comes along, it will be easy to remove the simple hack.

It looks like Roman is on my case.  This is good.

(Of course, if you have a barn full of hogs, maybe
it's time to paint the barn ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
