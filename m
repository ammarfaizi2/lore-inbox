Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbVJXD5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbVJXD5y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 23:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVJXD5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 23:57:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:42990 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750962AbVJXD5x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 23:57:53 -0400
Subject: Re: Robust Futexes status
From: Sven-Thorsten Dietrich <sven@mvista.com>
To: david singleton <dsingleton@mvista.com>
Cc: robustmutexes@lists.osdl.org, Roy Reichwein <rreichwein@mvista.com>,
       linux-kernel@vger.kernel.org, Kevin Morgan <kmorgan@mvista.com>
In-Reply-To: <DFD605A2-4406-11DA-8ABF-000A959BB91E@mvista.com>
References: <DFD605A2-4406-11DA-8ABF-000A959BB91E@mvista.com>
Content-Type: text/plain
Date: Sun, 23 Oct 2005 20:48:00 -0700
Message-Id: <1130125681.5296.5.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-23 at 13:52 -0700, david singleton wrote:
> 	Inaky Perez-Gonzalez   has a wonderful suite of performance, stress and
> functionality tests for the fusyn pthreads mutex package.

> 	The graphs are just to show relative performance for the different 
> flavor kernels.  The
> kernel's perform quite closely regardless of the 'flavor' of kernel.  
> The kernels have quite a few
> debugging options turned so I can look for any problems so performance 
> is not optimal.
> 

The Mutex ownership change seems to climb with waiting threads.

Its hard to tell with the log-n X-axis scale, but does this possibly
correlate to the deadlock-detect option?

If Deadlock-detect is enabled we should be seeing a graph proportional
to n-squared on a linear X axis.

If deadlock detect is disabled, the wait time should plateau for very
large N.

Sven


> 	It appears the robust futex functionality is healthy in all flavors of 
> kernel.
> 
> 	
> 
> David
> 
> 
> 
> 
-- 
***********************************
Sven-Thorsten Dietrich
Real-Time Software Architect
MontaVista Software, Inc.
1237 East Arques Ave.
Sunnyvale, CA 94085

Phone: 408.992.4515
Fax: 408.328.9204

http://www.mvista.com
Platform To Innovate
*********************************** 

