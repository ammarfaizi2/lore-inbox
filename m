Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161365AbWHEKv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161365AbWHEKv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 06:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161426AbWHEKv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 06:51:27 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62222 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161365AbWHEKv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 06:51:26 -0400
Date: Sat, 5 Aug 2006 12:51:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       Zachary Amsden <zach@vmware.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       v4l-dvb-maintainer@linuxtv.org, linux-acpi@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] Options depending on STANDALONE
Message-ID: <20060805105122.GT25692@stusta.de>
References: <44D1CC7D.4010600@vmware.com> <1154603822.2965.18.camel@laptopd505.fenrus.org> <44D23B84.6090605@vmware.com> <20060803190327.GA14237@kroah.com> <44D24B31.2080802@vmware.com> <20060803193600.GA14858@kroah.com> <20060803195617.GD16927@redhat.com> <20060803202543.GH25692@stusta.de> <Pine.LNX.4.58.0608031610110.9178@shell2.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608031610110.9178@shell2.speakeasy.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 04:40:25PM -0700, Trent Piepho wrote:
> On Thu, 3 Aug 2006, Adrian Bunk wrote:
> > On Thu, Aug 03, 2006 at 03:56:17PM -0400, Dave Jones wrote:
> > > You're describing PREVENT_FIRMWARE_BUILD.  The text Zach quoted is from
> > > STANDALONE, which is something else completely.  That allows us to not
> > > build drivers that pull in things from /etc and the like during compile.
> > > (Whoever thought that was a good idea?)
> >
> >
> > Is DVB_AV7110_FIRMWARE really still required?
> > ALL other drivers work without such an option.
> 
> The other DVB drivers that need firmware load it when the device is opened
> or used (ie.  a channel is tuned).  At least for the ones I'm familiar
> with.  If they are compiled directly into the kernel, they can still use
> FW_LOADER since the loading won't happen until utill well after booting is
> done.
> 
> For AV7110, it looks like the firmware loading is done when the driver is
> first initialized.  If AV7110 is compiled into the kernel, FW_LOADER can
> not be used.  The filesystem with the firmware won't be mounted yet.
> 
> So AV7110 has an option to compile a firmware file into the driver.

But is there a technical reason why this has to be done this way?

This is the onle (non-OSS) driver doing it this way, and Zach has a 
point that this is legally questionable.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

