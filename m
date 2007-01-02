Return-Path: <linux-kernel-owner+w=401wt.eu-S1755397AbXABROp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbXABROp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 12:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755393AbXABROo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 12:14:44 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:56192 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390AbXABROn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 12:14:43 -0500
Date: Tue, 2 Jan 2007 18:09:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mark Lord <lkml@rtr.ca>
cc: Jens Axboe <jens.axboe@oracle.com>, Rene Herman <rene.herman@gmail.com>,
       Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
In-Reply-To: <459A73CB.8010901@rtr.ca>
Message-ID: <Pine.LNX.4.61.0701021807500.4001@yvahk01.tjqt.qr>
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com>
 <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com>
 <4599992D.8000607@rtr.ca> <20070102083414.GQ2483@kernel.dk> <459A73CB.8010901@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 2 2007 10:01, Mark Lord wrote:
> Jens Axboe wrote:
>> 
>> > But surely one of (not sure which) sync+async or async+sync may also
>> > be okay?
>> > Or would it?
>> 
>> Async merge to sync request should be ok. But I wonder what happens with
>> hdparm, since it seems to trigger one of these tests. Very puzzling.
>> I'll dive in and take a look.
>
> The code (written 10 years ago) isn't the best in the world,
> and will be redone entirely for hdparm-7.0 this year.
>
> But right now, it essentially does this:
>
> loop:
> seek( to sector zero );
> read( 2MBytes );
> repeat loop for 3 seconds

Well for pure reading speed, I already use  dd_rescue -d /dev/hda /dev/null
Gives the same as hdparm -t when acting on uncached data.


	-`J'
-- 
