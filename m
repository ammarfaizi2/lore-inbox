Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbUAaHsT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 02:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUAaHsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 02:48:19 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:12719 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263796AbUAaHsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 02:48:16 -0500
Date: Sat, 31 Jan 2004 20:48:29 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Software Suspend 2.0
In-reply-to: <20040131073848.GE7245@digitasaru.net>
To: trelane@digitasaru.net
Cc: Luke-Jr <luke7jr@yahoo.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1075535309.17727.79.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1075436665.2086.3.camel@laptop-linux>
 <200401310622.17530.luke7jr@yahoo.com>
 <1075531042.18161.35.camel@laptop-linux>
 <20040131064757.GB7245@digitasaru.net>
 <1075532166.17727.41.camel@laptop-linux>
 <20040131071619.GD7245@digitasaru.net>
 <1075534088.18161.61.camel@laptop-linux> <20040131073848.GE7245@digitasaru.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy.

On Sat, 2004-01-31 at 20:38, Joseph Pingenot wrote:
> Yay!  Yet again does annoyance reign victorious!

Well, I wouldn't really count two requests from two people as annoyance
:>

> >>   any specific way to create the swap space for saving the state to?
> >Suspend2 will use any swap space you have available. It will even
> >automatically turn on a swap partition or file for you at the start of
> >suspending, and turn it off at the end. It doesn't care about how the
> >swap space is distributed or whether it's a partition or a file or a
> >combination. Saving to local IDE and SCSI is tested, but I've had
> >limited success with SCSI due to the lack of power management on the
> >drives I was testing with (the machine resumed up to the point where it
> >wanted to use the SCSI drive again with the restored kernel, at which
> >point the driver paniced because the request numbers were out of sync).
> 
> Hmmm.  Would turning on the swap space be a better option then?  I had
>   left it off so that it wouldn't get used.

It depends how much swap gets used in your normal activity. A good rule
of thumb is to make sure you have as much swap as RAM, plus a little
more for any genuine swapping the system is doing. Then you'll be able
to save a full image without freeing up any memory... and when you do
resume, your system will be as responsive as it would be if you'd never
suspended.

> Something I was wondering about: what happens then if the swap space
>   is all filled?  I liked having a dedicated partition so that that
>   wouldn't be an issue.

If there's not swap space to store the image in, suspend tries to free
memory until there is. In the worst case, it will reach a point where it
can't free any more memory, give up and cleanly back out. (Or that's the
plan, another email I just received means I will shortly double check
this is happening correctly under 2.6).

> Hmm.  I'm hoping to take advantage of 2.6.2-rc3's ACPI updates
>   (I have some acpi wonkiness which is undoubtedly related to
>   Dell and its infamous DSDTs).  Any chance you could make that
>   your first -rc target?  :)  I'll give you a lollipop whenever
>   I see you IRL.

Haha! See what I can do.

Nigel

> Anyhow, I'm gonna hit the hay.  Thanks for the great work; you're
>   truly an asset to Kiwi-dom.  ;)

Thank you.

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

