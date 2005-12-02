Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbVLBAM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbVLBAM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbVLBAM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:12:59 -0500
Received: from ozlabs.org ([203.10.76.45]:1212 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932575AbVLBAM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:12:59 -0500
Subject: Re: Two module-init-
From: Rusty Russell <rusty@rustcorp.com.au>
To: Scott James Remnant <scott@ubuntu.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, linux-input@atrey.karlin.mff.cuni.cz,
       vojtech@suse.cz
In-Reply-To: <1133359773.2779.13.camel@localhost.localdomain>
References: <1133359773.2779.13.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 11:12:56 +1100
Message-Id: <1133482376.4094.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-30 at 14:09 +0000, Scott James Remnant wrote:
> Hi Rusty,
> 
> Attached are two patches to module-init-tools from Ubuntu.
> 
> The first (input_table_size) is a catch-up with 2.6.15, it's adding an
> extra field to the input_device_id struct; m-u-t needs updating to be
> able to read the modules correctly.

Hi Scott,

	Unfortunately, it's not that simple.  Your patch will break previous
kernels, which have a smaller structure.  I've had the discussion years
ago with the input people on using module aliases, and it's not entirely
trivial.  I will prepare another patch, however.

Meanwhile, as noone seems to use swbit in struct input_device_id,
perhaps we can remove it for 2.6.15?

> The second (use_blacklist) adds a "-b" flag to modprobe that performs
> blacklist checking on those modules listed on the command line, it's
> handy for use when calling modprobe from udev for those subsystems
> without MODALIAS yet (input, ccw, etc.)

Hmm, well, the answer to that is the same as above.  ccw should have
support now, so it's just input we're missing I think.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

