Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291117AbSBLP3K>; Tue, 12 Feb 2002 10:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291121AbSBLP3C>; Tue, 12 Feb 2002 10:29:02 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:30482 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291114AbSBLP26>; Tue, 12 Feb 2002 10:28:58 -0500
Date: Tue, 12 Feb 2002 16:28:34 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020212162834.A25617@suse.cz>
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <20020212132846.A7966@suse.cz> <3C690E56.3070606@evision-ventures.com> <20020212135701.A16420@suse.cz> <3C6915FC.2020707@evision-ventures.com> <20020212144300.A18431@suse.cz> <3C691F9C.10303@evision-ventures.com> <20020212154251.A25201@suse.cz> <3C693357.8000204@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C693357.8000204@evision-ventures.com>; from dalecki@evision-ventures.com on Tue, Feb 12, 2002 at 04:23:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 04:23:03PM +0100, Martin Dalecki wrote:

> Anyway, you apparently still missed to kill:
> 
>      int *bs, max_ra; in ide-probe.c
> 
> as well as: xpram_rahead and friends in s390 code
> 
> The attached patch is fixing this.

Thanks.

> BTW.> Since there is no longer any difference about the request head
> handling between IDE and SCSI, what about the idea of moving the whole
> ide interface stuff under the umbrella of SCSI host adapter? This
> would be a true cleanup and make the whole ide-scsi and ide-atapi mess
> go away. IDE is moving fast toward SCSI on the logical level anyway
> and it would make the hwif macro/lookup crap in the ide code go
> magically way! At least this generic device handler search stuff
> should be merged between them (I'm trully tempted to give it a shoot
> this afternoon.) The only thing it could result in, which would maybe
> surprise some would be the fact that the major of his root device
> could just go suddenly away... But hey! What's the heck - we are in
> odd kernel series anyway ;-).

This is an idea I'm toying with for quite a long time already. And I
think this is a good idea as well. I have no more time to spend coding
today, so if you have the afternoon, but I'll definitely find some to
read the diff if you do this change!

-- 
Vojtech Pavlik
SuSE Labs
