Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270328AbTG1Q5j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 12:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270332AbTG1Q5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 12:57:39 -0400
Received: from 213-0-201-143.dialup.nuria.telefonica-data.net ([213.0.201.143]:19602
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S270328AbTG1Q5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 12:57:37 -0400
Date: Mon, 28 Jul 2003 19:12:51 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O10int for interactivity
Message-ID: <20030728171251.GA8605@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200307280112.16043.kernel@kolivas.org> <20030728075106.GA660@gmx.de> <20030728005543.0dca9531.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728005543.0dca9531.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 28 July 2003, at 00:55:43 -0700,
Andrew Morton wrote:

> There's a known problem with OpenOffice and its use of sched_yield(). 
> sched_yield() got changed in 2.6 and it makes OO unusable when there is
> other stuff happening.
> 
> Apparently it has been fixed in recent OpenOffice versions.  If you cannot
> reproduce this problem in any other application I'd be saying it is "not a
> bug".
> 
This must be the reason behind a simple "Save..." of a little OpenOffice
Writer document taking 3 seconds with no activity on the box, and two
minutes when "make bzImage", or "yes" or anyhting CPU intensive.

On the other hand, OO saves files (which is a CPU-bound process) only
marginally slower under heavy hard disk read activity than on an idle
system. Tested with 2.6.0-test2 and with 2.6.0-test2 with latest
scheduler patch from Ingo (2.6.0-test1-G6).

Regards, 

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test1-bk3)
