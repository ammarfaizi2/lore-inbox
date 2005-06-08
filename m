Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVFIALV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVFIALV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVFIAFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:05:31 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:35810 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262234AbVFIAAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:00:53 -0400
Subject: Re: [PATCH] capabilities not inherited
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Alexander Nyberg <alexn@telia.com>, Manfred Georg <mgeorg@arl.wustl.edu>,
       gregkh@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20050608215904.GE13152@shell0.pdx.osdl.net>
References: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu>
	 <20050608204430.GC9153@shell0.pdx.osdl.net>
	 <1118265642.969.12.camel@localhost.localdomain>
	 <20050608215904.GE13152@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 19:49:25 -0400
Message-Id: <1118274566.4539.28.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 14:59 -0700, Chris Wright wrote:
> * Alexander Nyberg (alexn@telia.com) wrote:
> > btw since the last discussion was about not changing the existing
> > interface and thus exposing security flaws, what about introducing
> > another prctrl that says maybe PRCTRL_ACROSS_EXECVE?
> 
> It's not ideal (as you mention, mess upon mess), but maybe it is the
> sanest way to go forward.
> 
> > Any new user-space applications must understand the implications of
> > using it so it's safe in that aspect. Yes?
> 
> At least less-likely to surprise ;-)

Any new user-space application developers that think about using
capabilities for anything should run away screaming.  When the JACK
developers proposed extending the mechanism to meet our needs, we were
basically told the capabilities subsystem is deeply broken and that we'd
have to rewrite the subsystem to do anything useful.  We ended up
shoehorning LSM and finally rlimits into doing what we need.  Please see
various "realtime LSM" threads for more (a LOT more) on the topic.

Lee

