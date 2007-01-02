Return-Path: <linux-kernel-owner+w=401wt.eu-S1753291AbXABPBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbXABPBc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 10:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbXABPBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 10:01:32 -0500
Received: from rtr.ca ([64.26.128.89]:4432 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbXABPBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 10:01:32 -0500
Message-ID: <459A73CB.8010901@rtr.ca>
Date: Tue, 02 Jan 2007 10:01:31 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Rene Herman <rene.herman@gmail.com>, Tejun Heo <htejun@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com> <4599992D.8000607@rtr.ca> <20070102083414.GQ2483@kernel.dk>
In-Reply-To: <20070102083414.GQ2483@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>
>> But surely one of (not sure which) sync+async or async+sync may also be 
>> okay?
>> Or would it?
> 
> Async merge to sync request should be ok. But I wonder what happens with
> hdparm, since it seems to trigger one of these tests. Very puzzling.
> I'll dive in and take a look.

The code (written 10 years ago) isn't the best in the world,
and will be redone entirely for hdparm-7.0 this year.

But right now, it essentially does this:

loop:
	seek( to sector zero );
	read( 2MBytes );
	repeat loop for 3 seconds

Cheers
