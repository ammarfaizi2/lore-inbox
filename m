Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291392AbSBMGB3>; Wed, 13 Feb 2002 01:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291393AbSBMGBT>; Wed, 13 Feb 2002 01:01:19 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:58121
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S291392AbSBMGBF>; Wed, 13 Feb 2002 01:01:05 -0500
Date: Tue, 12 Feb 2002 21:50:39 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020212162834.A25617@suse.cz>
Message-ID: <Pine.LNX.4.10.10202122147550.32729-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just maybe if the LOT of you would back off you may see

Uniform Storage Driver.

Just catch a clue for two seconds and see that I have packetized the
ATA-Command Block IO.  Since you have not a clue of why it was done,
please continue with your hair brained ideas.

Ever heard of SAS or FPDMA ?

Don't screw with what you do not know about.


On Tue, 12 Feb 2002, Vojtech Pavlik wrote:

> On Tue, Feb 12, 2002 at 04:23:03PM +0100, Martin Dalecki wrote:
> 
> > Anyway, you apparently still missed to kill:
> > 
> >      int *bs, max_ra; in ide-probe.c
> > 
> > as well as: xpram_rahead and friends in s390 code
> > 
> > The attached patch is fixing this.
> 
> Thanks.
> 
> > BTW.> Since there is no longer any difference about the request head
> > handling between IDE and SCSI, what about the idea of moving the whole
> > ide interface stuff under the umbrella of SCSI host adapter? This
> > would be a true cleanup and make the whole ide-scsi and ide-atapi mess
> > go away. IDE is moving fast toward SCSI on the logical level anyway
> > and it would make the hwif macro/lookup crap in the ide code go
> > magically way! At least this generic device handler search stuff
> > should be merged between them (I'm trully tempted to give it a shoot
> > this afternoon.) The only thing it could result in, which would maybe
> > surprise some would be the fact that the major of his root device
> > could just go suddenly away... But hey! What's the heck - we are in
> > odd kernel series anyway ;-).
> 
> This is an idea I'm toying with for quite a long time already. And I
> think this is a good idea as well. I have no more time to spend coding
> today, so if you have the afternoon, but I'll definitely find some to
> read the diff if you do this change!
> 
> -- 
> Vojtech Pavlik
> SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

