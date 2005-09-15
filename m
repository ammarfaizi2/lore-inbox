Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbVIOTSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVIOTSU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 15:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVIOTSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 15:18:20 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:8611 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964960AbVIOTSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 15:18:20 -0400
Date: Thu, 15 Sep 2005 12:18:05 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: zippel@linux-m68k.org, akpm@osdl.org, torvalds@osdl.org,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050915121805.66bfdcc9.pj@sgi.com>
In-Reply-To: <20050915104535.6058bbda.pj@sgi.com>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
	<20050912043943.5795d8f8.akpm@osdl.org>
	<20050912075155.3854b6e3.pj@sgi.com>
	<Pine.LNX.4.61.0509121821270.3743@scrub.home>
	<20050912153135.3812d8e2.pj@sgi.com>
	<Pine.LNX.4.61.0509131120020.3728@scrub.home>
	<20050913103724.19ac5efa.pj@sgi.com>
	<Pine.LNX.4.61.0509141446590.3728@scrub.home>
	<20050914124642.1b19dd73.pj@sgi.com>
	<Pine.LNX.4.61.0509150116150.3728@scrub.home>
	<20050915104535.6058bbda.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:
> if per chance the cs->count was one, then for an instant no other task
> was using this cpuset, and it had no children. 

Correction - a count of one means no other tasks using, period.

As you well know, whether there are children or not depends on
the state of the cpuset->children list.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
