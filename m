Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268889AbTCDAXJ>; Mon, 3 Mar 2003 19:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268890AbTCDAXJ>; Mon, 3 Mar 2003 19:23:09 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:30095 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S268889AbTCDAXI>; Mon, 3 Mar 2003 19:23:08 -0500
Date: Tue, 04 Mar 2003 13:36:41 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
In-reply-to: <20030303233923.GA2234@k3.hellgate.ch>
To: Roger Luethi <rl@hellgate.ch>
Cc: Troels Haugboelle <troels_h@astro.ku.dk>, Pavel Machek <pavel@suse.cz>,
       bert hubert <ahu@ds9a.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1046738201.3809.18.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030302202118.GA2201@outpost.ds9a.nl>
 <20030303003940.GA13036@k3.hellgate.ch>
 <1046657290.8668.33.camel@laptop-linux.cunninghams>
 <20030303113153.GA18563@outpost.ds9a.nl>
 <20030303122325.GA20929@atrey.karlin.mff.cuni.cz>
 <20030303123551.GA19859@outpost.ds9a.nl>
 <20030303124133.GH20929@atrey.karlin.mff.cuni.cz>
 <1046700474.3782.197.camel@localhost> <20030303143006.GA1289@k3.hellgate.ch>
 <1046729210.1850.8.camel@laptop-linux.cunninghams>
 <20030303233923.GA2234@k3.hellgate.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 12:39, Roger Luethi wrote:
> On Tue, 04 Mar 2003 11:06:50 +1300, Nigel Cunningham wrote:
> > You were hitting the BUG_ON before swsusp was even trying to write the
> > image?!! That is interesting! Since count_and_copy is first called post
> > driver suspend in the current version, perhaps they are somehow related.
> > (This is before swsusp tries to write any of the image to disk).
> 
> Huh? After a glance at the code I agree that drivers_suspend happens before
> count_and_copy_data_pages, but that means hitting the BUG_ON in
> idedisk_suspend before the panic in count_and_copy_data_pages is what I'd
> expect. How is that remarkable? ... My current kernel has HIGHMEM enabled,
> but previous ones that failed the same way didn't.

I was surprised because I thought you were getting the BUG_ON during
writing the image. Now I see that it's well beforehand.

> Anyway, a few more tests showed that hdparm -u1 helps if I have lots of
> memory used (say for fs caches). In two out of two tests, I saw Pavel's
> request to send him 1 GB RAM via email.

On this topic, would you be willing to test a 2.4 version that supported
highmem? I haven't written support yet, but hope to do it shortly. (I
don't have that much ram myself so you can send me 1GB if you prefer
:>).

> Suspending directly from a clean boot (after issuing the same hdparm -u1
> commands for both disks) I hit the BUG_ON in idedisk_suspend (two out of
> two tests, too).

Hmmm.. strange.

Regards,

Nigel

