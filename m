Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVDBOPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVDBOPn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 09:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVDBOPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 09:15:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:41116 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261508AbVDBOPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 09:15:36 -0500
Date: Sat, 2 Apr 2005 08:15:03 -0600 (CST)
From: Bruce Losure <blosure@sgi.com>
To: Paul Jackson <pj@engr.sgi.com>
cc: blosure@sgi.com, <mochel@digitalimplant.org>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: new SGI TIOCX driver in *-mm driver model locking broken
In-Reply-To: <20050402041009.72500c6f.pj@engr.sgi.com>
Message-ID: <Pine.LNX.4.44.0504020813220.28843-100000@fsgi025.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Apr 2005, Paul Jackson wrote:

> Bruce - a related issue that fell out of the previous problem.  I
> disabled SGI_TIOCX, with
> 
> # CONFIG_SGI_TIOCX is not set
> 
> and now 2.6.12-rc1-mm4 doesn't build SN2 because SGI_MBCS is still
> enabled in my .config, even after doing 'make oldconfig':
> 
> CONFIG_SGI_MBCS=m
> 
	...
> and indeed there are many tiocx references in drivers/char/mbcs.c.
> 
> I'm not a CONFIG wizard, but I would suspect that there should be
> some sort of dependency in Kconfig, of SGI_MBCS on SGI_TIOCX, so
> that I couldn't ask for this bogus config (MBCS on, TIOCX off).
> 

I'll try to figure out how to make that dependency and submit a patch.

-Bruce

-- 
Bruce Losure                            internet: blosure@sgi.com
SGI                                     phone:    +1 651 683-7263
2750 Blue Water Rd			vnet:	  233-7263
Eagan, MN, USA 55121

