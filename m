Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWAJOUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWAJOUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWAJOUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:20:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58903 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932186AbWAJOUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:20:53 -0500
Date: Tue, 10 Jan 2006 15:22:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
Message-ID: <20060110142244.GJ3389@suse.de>
References: <20060110125852.GA3389@suse.de> <43C3C0B8.30205@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C3C0B8.30205@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10 2006, Mark Lord wrote:
> Jens Axboe wrote:
> ..
> >+choice
> >+	depends on NOHIGHMEM
> 
> Is that dependency strictly needed here?

Probably not. Well at least it could be relaxed, I just wanted to be
safe and avoid any extra complications due to this.

> (Mark hurriedly applies patch and rebuilds kernel on 2G notebook..)

You may want to change the 2G split to 0x78000000 as noted by Byron,
then you can skip highmem completely if you so wanted.

-- 
Jens Axboe

