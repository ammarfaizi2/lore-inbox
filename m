Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWHYD5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWHYD5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 23:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbWHYD5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 23:57:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1160999AbWHYD5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 23:57:42 -0400
Date: Thu, 24 Aug 2006 20:54:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] eCryptfs: Netlink functions for public key
Message-Id: <20060824205419.c3894612.akpm@osdl.org>
In-Reply-To: <20060824181831.GB17658@us.ibm.com>
References: <20060824181722.GA17658@us.ibm.com>
	<20060824181831.GB17658@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2006 13:18:32 -0500
Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> eCryptfs netlink type, header updates, and messaging code to provide
> support for userspace callout to perform public key operations.
> 

That tells us (with maximum terseness) what it does.  We're left to our own
devices to work out why it does this, how it does it and why it does it in
the way in which it does it?   This leads to dumb questions ;)

- We have a great clod of key mangement code in-kernel.  Why is that not
  suitable (or growable) for public key management?

- Is it appropriate that new infrastructure for public key management be
  private to a particular fs?

- I see code in there in which the kernel "knows" about specific
  userspace processes.  By uid and pid.  What's all that doing and why is
  it done that way?

  What happens if one of these daemons exits without sending a quit message?

- It uses netlink to transport keys.  What are the security implications
  of this?  (Can they be sniffed, for example?)

- _why_ does it use netlink?

It's obvious that a string of design decisions have gone into all of this. 
Please tell us about them.  Please also tell us the answers to all the
other questions I'd have asked if I knew enough about this to ask them.


>   *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
> + *              Trevor S. Highland <trevor.highland@gmail.com>
> + *		Tyler Hicks <tyhicks@ou.edu>

Do we have signoffs from Trevor and Tyler?
