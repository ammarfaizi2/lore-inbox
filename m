Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTEZTUO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 15:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTEZTUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 15:20:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62421 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262153AbTEZTUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 15:20:13 -0400
Date: Mon, 26 May 2003 21:33:27 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030526193327.GN845@suse.de>
References: <1053972773.2298.177.camel@mulgrave> <20030526181852.GL845@suse.de> <1053974830.1768.190.camel@mulgrave> <20030526190707.GM845@suse.de> <1053976644.2298.194.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053976644.2298.194.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26 2003, James Bottomley wrote:
> On Mon, 2003-05-26 at 15:07, Jens Axboe wrote:
> > Alright, so what do you need? Start out with X tags, shrink to Y (based
> > on repeated queue full conditions)? Anything else?
> 
> Actually, it's easier than that: just an API to alter the number of tags
> in the block layer (really only the size of your internal hash table). 
> The actual heuristics of when to alter the queue depth is the province
> of the individual drivers (although Doug Ledford was going to come up
> with a generic implementation).

That's actually what I meant, that the SCSI layer would call down into
the block layer to set the size. I don't/want to know about queue full
conditions.

The internal memory requirements for the queue table is small (a bit per
tag), so I think we can basically get away with just decrementing
->max_depth.

-- 
Jens Axboe

