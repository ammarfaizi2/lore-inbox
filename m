Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270621AbUJUIiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270621AbUJUIiw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 04:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270393AbUJUIe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 04:34:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8637 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270642AbUJUIcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 04:32:00 -0400
Date: Thu, 21 Oct 2004 10:31:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Adam Hunt <kinema@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I/O scheduler recomendation for Linux as a VMware guest
Message-ID: <20041021083126.GX10531@suse.de>
References: <b476569a0410201616415b0600@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b476569a0410201616415b0600@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20 2004, Adam Hunt wrote:
> I am forced to spend quite a bit of time with my only relatively
> powerful workstation booted into XP so I can do CAD work
> (unfortunately Autodesk's Inventor only runs on Windows).  Because of
> this unfortunate situation I am planning my first attempt to get the
> Linux install that I have on the other drive in this workstation to
> boot using VMware.  VMware has the ability to access raw disk
> partitions (as apposed to partitions stored in a file on a host
> partition) so I figure with some init and /etc magic I should be able
> to boot the system using VMware and when I am not drawing in Inventor
> I should be able to reboot and run Linux natively directly on the
> hardware.
> 
> What I am wondering is what I/O scheduler should I be using when the
> system is running within a VMware instance?  I figure that Windows
> will be scheduling the access to the physical hardware so I would
> assume that I want a bare bones priority based scheduler, something
> with the lowest possible overhead.  Is this correct?  If so, what
> would that scheduler be?

Probably deadline/cfq is the best fit, unless your host file is
perfectly laid out on disk in which case you can play with noop. As
Randy already pointed out, you can switch dynamically in the 2.6.9-bk
snapshots - so the best thing for you to do if you want to know for
sure, is to benchmark each of them for your workload. For most things
there should not be a noticable difference between cfq and deadline,
whether as makes a difference (for better or worse) is very work-load
dependent.

-- 
Jens Axboe

