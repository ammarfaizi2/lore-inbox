Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbULTIZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbULTIZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbULTIZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:25:25 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:5787 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261491AbULTIQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 03:16:54 -0500
Message-ID: <41C68A6D.6060801@yahoo.com.au>
Date: Mon, 20 Dec 2004 19:16:45 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>, Jens Axboe <axboe@suse.de>
Subject: Re: /sys/block vs. /sys/class/block
References: <1103526532.5320.33.camel@gaston>
In-Reply-To: <1103526532.5320.33.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> I'm trying to understand why we have /sys/block instead
> of /sys/class/block, and so far, I haven't found a single good argument
> justifying it... It just messes up the so far logical layout of sysfs
> for no apparent reason.
> 
> I also didn't find where /sys/block is created, but that's maybe because
> I didn't search too hard :) So I'm not coming up with a patch yet, but
> unless somebody can convince me it should stay here, I'll do so soon.
> 
> If the reason not to fix it is backward compatibility, then that would
> really be a shame we managed already to turn the brand new sysfs into a
> mess with no hope of fixing it... If there is really a problem there,
> maybe we could move it and keep a compat symlink for a few kernel
> revs... ?
> 

Seems like that's where it belongs.

The reason why it is in /sys/block is because it is apparently a "subsystem",
and using decl_subsys - drivers/block/genhd.c

Nick
