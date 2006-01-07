Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWAGOUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWAGOUH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 09:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWAGOUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 09:20:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61293 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751404AbWAGOUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 09:20:05 -0500
Date: Sat, 7 Jan 2006 15:22:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Sebastian <sebastian_ml@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060107142201.GC3389@suse.de>
References: <43BE24F7.6070901@triplehelix.org> <20060106232522.GA31621@section_eight.mops.rwth-aachen.de> <5bdc1c8b0601061530l3a8f4378o3b9cb96c187a6049@mail.gmail.com> <20060107103901.GA17833@section_eight.mops.rwth-aachen.de> <20060107105649.GT3389@suse.de> <20060107112443.GA18749@section_eight.mops.rwth-aachen.de> <20060107115340.GW3389@suse.de> <20060107115449.GB20748@section_eight.mops.rwth-aachen.de> <20060107115947.GY3389@suse.de> <20060107140843.GA23699@section_eight.mops.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107140843.GA23699@section_eight.mops.rwth-aachen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07 2006, Sebastian wrote:
> (please, don't drop me from the cc list!!)
> 
> On Sa, Jan 07, 2006 at 14:57:55 +0100, Jens Axboe wrote:
> >(please, don't drop me from the cc list!!)
> >
> >it might be using the older sg interface, opening read/write to /dev/sgX
> >char devices directly. In which case you can't test it with ide-cd,
> >sadly.
> 
> You wrote about accessing the drive with SG_IO while using ide-cd. So it
> is possible to use scsi commands though using ide-cd? I can't find any
> documentation on that, though. Could you point me towards it? I can try
> to adapt cdparanoia.

You can use SG_IO on any block device that accepts "SCSI" commands in
the end, like ide-cd. Google for the sg driver documentation and you
will find there are various ways to submit sg commands. cdparanoia
likely uses the old variant of opening the char device and read/writing
commands to it, if you convert it to SG_IO it could use that transport
always (on 2.6 kernels and newer).

-- 
Jens Axboe

