Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVLTUww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVLTUww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVLTUww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:52:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52002 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932098AbVLTUwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:52:51 -0500
Date: Tue, 20 Dec 2005 21:54:25 +0100
From: Jens Axboe <axboe@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Ben Collins <ben.collins@ubuntu.com>, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [PATCH] block: Better CDROMEJECT
Message-ID: <20051220205425.GT3734@suse.de>
References: <1135047119.8407.24.camel@leatherman> <20051220074652.GW3734@suse.de> <1135082490.16754.0.camel@localhost.localdomain> <20051220132821.GH3734@suse.de> <1135085557.16754.2.camel@localhost.localdomain> <20051220133939.GI3734@suse.de> <1135087637.16754.12.camel@localhost.localdomain> <1135111300.27117.41.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135111300.27117.41.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20 2005, john stultz wrote:
> Although from just looking at it, don't you still need to add
> ALLOW_MEDIUM_REMOVAL in the verify_command() list for this to work?
> 
> Alternatively, would just the "safe_for_write(ALLOW_MEDIUM_REMOVAL);" in
> verify_command along with the eject-opens-RW fix have almost the same
> effect?

The command is already in the safe-for-write list, so you don't have to
change anything but fix eject to open the device O_RDWR.

-- 
Jens Axboe

