Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbULQH42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbULQH42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 02:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbULQH42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 02:56:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40155 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262767AbULQH4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 02:56:22 -0500
Date: Fri, 17 Dec 2004 08:56:19 +0100
From: Jens Axboe <axboe@suse.de>
To: "Steven A. DuChene" <sduchene@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: all three IO Schedulers turned on in 2.6.10-rc3-mm1 ???
Message-ID: <20041217075618.GH3045@suse.de>
References: <20041216141018.D927@lapsony.sc04.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216141018.D927@lapsony.sc04.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16 2004, Steven A. DuChene wrote:
> I downloaded and built the 2.6.10-rc3-mm1 kernel and I noticed while
> configuring it that in the Device Drivers > Block devices > IO Schedulers
> area that by default all three IO Schedulers are turned on. Is this a
> normal condition or is there only supposed to be one of these turned on?

They all default to on. There's actually a fourth that is also on, but
you cannot turn that off (noop). It's there if you disable the other
three, in lack of a better way to express that in Kconfig.

> The reason I am concerned about this is that ever since I have booted
> into this kernel I have a lot of things failing and when they fail
> they return a message like "Inappropriate ioctl for device"

The io schedulers don't provide any ioctls, must be something else. I
suggest you strace whatever program is throwing these errors and find
out what is going wrong.

-- 
Jens Axboe

