Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVEYXcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVEYXcD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 19:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVEYXcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 19:32:03 -0400
Received: from smtpout.mac.com ([17.250.248.86]:43973 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261447AbVEYXb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 19:31:56 -0400
In-Reply-To: <4295005F.nail2KW319F89@burner>
References: <4847F-8q-23@gated-at.bofh.it> <E1Db3zm-0004vF-9j@be1.7eggert.dyndns.org> <4295005F.nail2KW319F89@burner>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8E909B69-1F19-4520-B162-B811E288B647@mac.com>
Cc: linux-kernel@vger.kernel.org, 7eggert@gmx.de
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Date: Wed, 25 May 2005 19:31:46 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 25, 2005, at 18:46:55, Joerg Schilling wrote:
> "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>"  
> <7eggert@gmx.de> wrote:
>> I just burned a CD on my IDE-burner using mmc_cdr with cdrtools-2.01
>> (the one without the hack) on a vanilla 2.6.11.10. I can even scan
>> both my SCSI and IDE devices using -dev=ATAPI, but not without -dev.
>
> The unability to give this kind of convenience to cdrecord users is  
> a result
> of the refusal of the Linux kernel crew to include the kernel internal
> device instance numbers in the ioctl structures I need to read.

There is a specific reason that the numbers are _kernel_internal_!!!   
I set up
my udev so that my green CD burner is /dev/green_burner, and my blue  
CD burner
is /dev/blue_burner.  Please tell me again why exactly I can't just  
give the
option -dev=/dev/green_burner and have it use my green CD burner?   
That's a lot
easier than messing with random groups of 3 numbers and trying to  
remember in
which order I plugged in my burners, and which kernel I'm running, so  
I can
remember the enumeration order, etc.

> Note that the fields are there but the information is intentionally  
> obscured
> for come of the calls just to make the life of cdrecord useers  
> harder :-(

The information is obscured because userspace shouldn't know or care

>> (I'm running as user, and cdrecord has no need for suid bits.)
>
> I am frequently reading false claims like this. Usually from people  
> who
> do not have the needed SCSI background knowledge to understand that
> SCSI is a protocol where commands frequently fail by intention in  
> order to
> propagate a state or a implementation level to the application.

What exactly is false about the claim?

> If you don't call cdrecord as root, you will not be able to lock in  
> memory
> and to raise priority in order to prevent buffer underuns.

I burn CDs fine all the time as a user, and I _don't_ need to lock  
memory or
raise priority, because I have a good scheduler, plenty of RAM, and  
dual CPUs.
It would be nice if you could let me leave on the _hardware_ BurnProof
technology designed to prevent that sort of thing, but it doesn't  
appear to
fit with your ideals of 100% perfect CDs, does it?  Besides, by the  
time we
hit the point where BurnProof would turn on, the disk is either  
completely
dead and useless (no burnproof), or slightly scarred and still  
useable (with
burnproof).  Personally, I'd rather have the latter.

> In addition (with Linux-2.6.8.1 or newer) you will not be able to  
> send some
> of the important SCSI commands mainly related to newer CD or DVD  
> drives. As
> a result, cdrecord cannot write DVDs

I was not under the impression that the free cdrecord could write DVDs.

> or ultra speed CD-RWs or cannot do other things....

Did you try submitting a list of important SCSI commands and their  
functions?
I suspect that if you provide a clear, concise list of harmless  
commands,
they would be included in the available command set.

> Not true: if only R/W fd would be allowed, no non root program  
> could do that.

Uhh, but I don't run cdrecord as root.  My /dev/green_burner device  
is owned
by root, has group "media", and perms rw-rw-r--.  Since this is a  
somewhat public
machine with lots of users in the "media" group, I don't want anybody  
to be able
to turn my drives into bricks.

> See above, this false claim is a result of the fact that you miss  
> the background
> knowledge on CD/DVD writing. Turning burnproof on degrades the  
> quality of the
> media and writing without burnproof but with the apropriate  
> privilleges just
> works fine.

Why can't you just provide an option to leave it on?  My Mac and Windows
computers seem to do just fine with it.  In fact, all modern CD-ROM  
drives
were designed to be able to read such "degraded" media, even "degraded"
media that also has scratches and dents and dings and scars and all  
sorts
of other glitches in the CD surface.

