Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVLTU6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVLTU6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVLTU6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:58:41 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:56008 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932095AbVLTU6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:58:40 -0500
Subject: Re: [PATCH] block: Better CDROMEJECT
From: john stultz <johnstul@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: Ben Collins <ben.collins@ubuntu.com>, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com
In-Reply-To: <20051220205823.GU3734@suse.de>
References: <1135047119.8407.24.camel@leatherman>
	 <20051220074652.GW3734@suse.de>
	 <1135082490.16754.0.camel@localhost.localdomain>
	 <20051220132821.GH3734@suse.de>
	 <1135085557.16754.2.camel@localhost.localdomain>
	 <20051220133939.GI3734@suse.de>
	 <1135087637.16754.12.camel@localhost.localdomain>
	 <1135111300.27117.41.camel@cog.beaverton.ibm.com>
	 <20051220205425.GT3734@suse.de>
	 <1135112115.27117.44.camel@cog.beaverton.ibm.com>
	 <20051220205823.GU3734@suse.de>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 12:58:37 -0800
Message-Id: <1135112317.27117.46.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 21:58 +0100, Jens Axboe wrote:
> On Tue, Dec 20 2005, john stultz wrote:
> > On Tue, 2005-12-20 at 21:54 +0100, Jens Axboe wrote:
> > > On Tue, Dec 20 2005, john stultz wrote:
> > > > Although from just looking at it, don't you still need to add
> > > > ALLOW_MEDIUM_REMOVAL in the verify_command() list for this to work?
> > > > 
> > > > Alternatively, would just the "safe_for_write(ALLOW_MEDIUM_REMOVAL);" in
> > > > verify_command along with the eject-opens-RW fix have almost the same
> > > > effect?
> > > 
> > > The command is already in the safe-for-write list, so you don't have to
> > > change anything but fix eject to open the device O_RDWR.
> > 
> > Errr? I don't see it in verify_command() from Linus' current git tree.
> > 
> > Is there some other name for the same command?
> 
> It's listed as GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL.

Ah! Ok, sorry about that! Indeed then, the eject fix appears to be all
that is needed.

Thanks for the clarification.
-john



