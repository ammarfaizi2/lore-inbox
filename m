Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTKYFBe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 00:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTKYFBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 00:01:34 -0500
Received: from [64.65.189.210] ([64.65.189.210]:58084 "EHLO
	mail.pacrimopen.com") by vger.kernel.org with ESMTP id S261965AbTKYFBc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 00:01:32 -0500
Subject: Re: RAID-0 read perf. decrease after 2.4.20
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031124100534.24941.qmail@web13902.mail.yahoo.com>
References: <20031124100534.24941.qmail@web13902.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1069736477.1552.11.camel@menion.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 24 Nov 2003 21:01:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-24 at 02:05, Martin Knoblauch wrote:
> >Hello All!
> >
> >Has anyone else experienced a drastic drop in read performance on
> >software
> >RAID-0 with post 2.4.20 kernels? We have a few Athlon XP's here at our
> >lab with double IDE disks on different channels set up as RAID-0. Some
> >bonnie++ benchmark results with various kernels, on the same machine
> >(Athlon XP 2400+, 2 GHz, 1.5 GB RAM, VIA chipset, 2*Maxtor 120 GB
> >6Y060L0):
> >write read
> >2.4.20-ac1: 88,000 135,000 K/sec
> >2.4.21-pre7: 93,000 75,000
> >2.4.22-ac4: 94,000 82,000
> 
> Hi,
> 
>  I can attest a similar drop in read performance on a IA64 box going
> from a 2.4.19ish kernel to 2.4.22. In our setup the RAID0 is LVM, not
> MD.The RAID is used a a scratch device for a out-of-core finite element
> program (NASTRAN).
> 
>  The setup is some 20 disks on 4 controllers. "iozone" read/reread
> Performance went from about 400MB/sec to 260 MB/sec, while write went
> up a notch. Unfortunatelly the read performance is more important for
> the application in question.
> 
>  Due to the fact that I have no controll over the use of the system I
> cannot make any experiments to find out what killed performance. Sorry
> :-(
> 
> Martin
> 
> =====
> ------------------------------------------------------
> Martin Knoblauch
> email: knobi@knobisoft.de or knobi@rocketmail.com
> www:   http://www.knobisoft.de
> 
> 

And this isn't the read-ahead size change thing?

