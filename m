Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWBCIwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWBCIwt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 03:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWBCIwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 03:52:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41573 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751150AbWBCIws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 03:52:48 -0500
Date: Fri, 3 Feb 2006 09:54:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jim Crilly <jim@why.dont.jablowme.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Albert Cahalan <acahalan@gmail.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, j@bitron.ch
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203085459.GW4215@suse.de>
References: <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <1138915551.15691.123.camel@mindpipe> <20060202214938.GF10352@voodoo> <1138917406.15691.141.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138917406.15691.141.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02 2006, Lee Revell wrote:
> On Thu, 2006-02-02 at 16:49 -0500, Jim Crilly wrote:
> > On 02/02/06 04:25:50PM -0500, Lee Revell wrote:
> > > On Thu, 2006-02-02 at 16:09 -0500, Jim Crilly wrote:
> > > > Apparently O_EXCL was added by Ubuntu and Debian to stop
> > > > burns being corrupted by hald polling the device while a disc is
> > > > being burned. 
> > > 
> > > IO priorities are the correct solution...
> > > 
> > > Lee
> > 
> > Is this something that's available now?
> > 
> 
> Hmm, actually I'm not sure it would make a difference, as I don't think
> CD writing goes through the regular IO scheduler.

Right, you can only prioritize "regular" io, not stuff sent with SG_IO.
So it'll help burning only for the case of getting the data required to
the buffer, not in getting that data out to the burner. The latter is
usually not a problem though, as these requests take a 'short cut'
directly to the dispatch queue.

-- 
Jens Axboe

