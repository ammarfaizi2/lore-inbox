Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312302AbSDEGVQ>; Fri, 5 Apr 2002 01:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312316AbSDEGVG>; Fri, 5 Apr 2002 01:21:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61750 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312302AbSDEGU4>; Fri, 5 Apr 2002 01:20:56 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bcrl@redhat.com (Benjamin LaHaise), akpm@zip.com.au (Andrew Morton),
        rgooch@ras.ucalgary.ca (Richard Gooch), joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <E16tKI6-0007TJ-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Apr 2002 23:14:12 -0700
Message-ID: <m1sn6apt8r.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > I find that on heavily scsi systems: one machine spins each of 13 disks 
> > up sequentially.  This makes the initial boot take 3-5 minutes before 
> > init even gets its foot in the door.  If someone made a patch to spin 
> > up scsi disks on the first access, I'd gladly give it a test. ;-)
> 
> Ditto. Especially if it spun them down again when idle for a while. 
> 
> The scsi layer does several things serially it could parallelise. It isnt
> just disk spin up its also things like initialising all scsi controllers
> in parallel.

I'm interested in this kind of thing too.  Though I am wondering if the IDE
layer has the same kind of issues.  I notice because the kernel initialization
time is 50% of my boot time.  I have the kernel loaded 3 seconds from
power on...

My impression is that the time during kernel initialization is either
spent spinning up disks or in a million device probes and things going
on behind the scenes.  I haven't had a chance to look farther though.

Eric
