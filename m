Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbUCOVY5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUCOVY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:24:57 -0500
Received: from 162.100.172.209.cust.nextweb.net ([209.172.100.162]:65419 "EHLO
	jlundell.local") by vger.kernel.org with ESMTP id S262799AbUCOVYx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:24:53 -0500
Mime-Version: 1.0
Message-Id: <p0610033abc7bceda4ffd@[192.168.0.3]>
In-Reply-To: <20040314032501.GT20174@waste.org>
References: <40511868.4060109@usa.net>
 <m17jxqf2xf.fsf@ebiederm.dsl.xmission.com> <4051EB42.8060903@pobox.com>
 <m13c8ef11b.fsf@ebiederm.dsl.xmission.com>
 <p0610032fbc77de2c9c28@[192.168.0.3]> <20040314032501.GT20174@waste.org>
Date: Mon, 15 Mar 2004 13:24:41 -0800
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@lundell-bros.com>
Subject: Re: [PATCH] ethtool.h should use userspace-accessible types
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:25 PM -0600 3/13/04, Matt Mackall wrote:
>On Fri, Mar 12, 2004 at 01:48:54PM -0800, Jonathan Lundell wrote:
>>  At 10:06 AM -0700 3/12/04, Eric W. Biederman wrote:
>>  >My intent was to say:  Why change the types when there is no #ifdef
>>  >__KERNEL__ in the header.  With no #ifdef __KERNEL__ it exports
>>  >definitions that are private to the kernel making it not safe for
>>  >userspace to use.  With kernel private definitions in there it will
>>  >generate name space pollution if included by user space.
>>
>>  Presumably because it *is* included by userspace, because it defines
>>  the interface between the kernel and userspace; of course userspace
>>  will (does) include it.
>
>Well that's a bug. You don't include kernel headers in userspace.
>Doing so has been deprecated for 8 years and 3 major releases.

Then it's a bug for the ethtool maintainer. ethtool.c #includes 
ethtool-copy.h, a renamed copy of the kernel header file.

I'm familiar with the deprecation and continue to be bewildered by 
it. To take this particular example, ethtool.h defines an interface 
between a kernel facility and a userspace client. What's the 
non-deprecated method of sharing the interface definition?
-- 
/Jonathan Lundell.
