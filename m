Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVLTUvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVLTUvn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVLTUvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:51:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4130 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932079AbVLTUvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:51:36 -0500
Date: Tue, 20 Dec 2005 21:53:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ben Collins <bcollins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc6] block: Fix CDROMEJECT to work in more cases
Message-ID: <20051220205306.GS3734@suse.de>
References: <20051219195014.GA13578@swissdisk.com> <Pine.LNX.4.64.0512200930490.4827@g5.osdl.org> <20051220174948.GP3734@suse.de> <Pine.LNX.4.64.0512201005370.4827@g5.osdl.org> <1135111130.16754.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135111130.16754.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20 2005, Ben Collins wrote:
> However, I don't see the issue with using READ. We know this isn't a
> write operation, we are sending a single command with no data. I know
> you say reads are precious, but 3 requests for something that isn't
> going to happen very often doesn't seem that bad.

It's not a READ either!

Yes I'm being stubborn, but my point stands. I'm not changing something
that is perfectly valid, "just because". If it finds a bug (you
mentioned ide-cd, I still want the details on that when you have the
time), then it's all for the better since it would bite us for other
paths as well.

In summary - it's not a bug, it doesn't need fixing.

> As for the 0x01, I don't know. The eject -s code does the exact same
> thing (AMR, SS:0x01, SS:0x02), so I copied the same mechanism because it
> is known to work.

Lets leave that out for now then, yes?

-- 
Jens Axboe

