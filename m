Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbUCNDZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 22:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUCNDZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 22:25:09 -0500
Received: from waste.org ([209.173.204.2]:16345 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263258AbUCNDZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 22:25:04 -0500
Date: Sat, 13 Mar 2004 21:25:01 -0600
From: Matt Mackall <mpm@selenic.com>
To: Jonathan Lundell <linux@lundell-bros.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethtool.h should use userspace-accessible types
Message-ID: <20040314032501.GT20174@waste.org>
References: <40511868.4060109@usa.net> <m17jxqf2xf.fsf@ebiederm.dsl.xmission.com> <4051EB42.8060903@pobox.com> <m13c8ef11b.fsf@ebiederm.dsl.xmission.com> <p0610032fbc77de2c9c28@[192.168.0.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p0610032fbc77de2c9c28@[192.168.0.3]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 01:48:54PM -0800, Jonathan Lundell wrote:
> At 10:06 AM -0700 3/12/04, Eric W. Biederman wrote:
> >My intent was to say:  Why change the types when there is no #ifdef
> >__KERNEL__ in the header.  With no #ifdef __KERNEL__ it exports
> >definitions that are private to the kernel making it not safe for
> >userspace to use.  With kernel private definitions in there it will
> >generate name space pollution if included by user space.
> 
> Presumably because it *is* included by userspace, because it defines 
> the interface between the kernel and userspace; of course userspace 
> will (does) include it.

Well that's a bug. You don't include kernel headers in userspace.
Doing so has been deprecated for 8 years and 3 major releases.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
