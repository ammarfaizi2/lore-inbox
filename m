Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281834AbRLKQbI>; Tue, 11 Dec 2001 11:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281823AbRLKQa6>; Tue, 11 Dec 2001 11:30:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40463 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281834AbRLKQar>;
	Tue, 11 Dec 2001 11:30:47 -0500
Date: Tue, 11 Dec 2001 17:30:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Paul Larson <plars@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Scsi problems in 2.5.1-pre9
Message-ID: <20011211163037.GB13498@suse.de>
In-Reply-To: <1008065277.25964.5.camel@plars.austin.ibm.com> <20011211160543.GZ13498@suse.de> <20011211161959.GA13498@suse.de> <1008066868.25964.8.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1008066868.25964.8.camel@plars.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11 2001, Paul Larson wrote:
> On Tue, 2001-12-11 at 16:19, Jens Axboe wrote:
> 
> > It seems to affect all SCSI drivers with CLUSTERING enabled. Don't worry
> > about data consistency btw, the above is a warning only (the right
> > segment count is used).
> So... this isn't a problem that my machine was locked up, I couldn't log
> in, or break out of the hung process, and it came back in an

Of course it's a problem, it locked because of hitting the segment BUG
in ll_rw_blk most likely. 

> inconsistant state?

... which fsck fixed, I'm saying the condition in itself does not cause
data corruption.

-- 
Jens Axboe

