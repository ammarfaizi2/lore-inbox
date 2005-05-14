Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVENKWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVENKWv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 06:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVENKWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 06:22:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63250 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262466AbVENKWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 06:22:49 -0400
Date: Sat, 14 May 2005 11:22:42 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4 1/12] (dynamic sysfs callbacks) update device attribute callbacks
Message-ID: <20050514112242.A24975@flint.arm.linux.org.uk>
Mail-Followup-To: Yani Ioannou <yani.ioannou@gmail.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <2538186705051402237a79225@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2538186705051402237a79225@mail.gmail.com>; from yani.ioannou@gmail.com on Sat, May 14, 2005 at 05:23:56AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 05:23:56AM -0400, Yani Ioannou wrote:
> This patch updates all device attribute callbacks to match the
> previously submitted sysfs dynamic callback device attribute patch
> which added the void * to the callback function signatures.

I missed commenting on this first time round.  What is the purpose behind
this idea?

Currently, sysfs attributes are generally static structures which don't
require allocation, and are shared between all objects.  I'm unable to
see what advantage adding this void pointer is supposed to give us,
other than having to dynamically allocate these structures if we want
to use them.

What's more, I don't really see what adding this buys us - we already
have the pointer which is supposed to identify the object passed in.

There's another question - how is the lifetime of the object pointed
to by this void pointer managed?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
