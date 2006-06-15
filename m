Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWFOGBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWFOGBR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 02:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWFOGBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 02:01:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15719 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932442AbWFOGBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 02:01:17 -0400
Date: Thu, 15 Jun 2006 08:01:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cfq_update_io_seektime oops
Message-ID: <20060615060152.GK1522@suse.de>
References: <20060615152131.A898607@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060615152131.A898607@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15 2006, Nathan Scott wrote:
> Hi Jens,
> 
> Just booting and testing on 2.6.17-rc5 I tripped over what looks
> like a divide by zero - I guess its at block/cfq-iosched.c, line
> ~1657 since that do_div in there looks like the only divide...

The patch for this was just merged in 2.6.17-rc6-git last night, so it
should be fine now. Just curious - did you have any slab debugging
features enabled?

> This was fairly late in bootup.  Lemme know if more info needed, I
> have booted this kernel several times without problem today, so it
> may not be easily reproducible.

It's a little obscure, I'm surprised to see you hit it :-)

-- 
Jens Axboe

