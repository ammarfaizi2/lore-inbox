Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWGIKCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWGIKCs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 06:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWGIKCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 06:02:48 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:40386 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964833AbWGIKCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 06:02:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Sun, 9 Jul 2006 12:03:15 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@suse.cz>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <20060708235434.GG2546@elf.ucw.cz> <200607091002.48153.ncunningham@linuxmail.org>
In-Reply-To: <200607091002.48153.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607091203.15586.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 02:02, Nigel Cunningham wrote:
> Hi.
> 
> On Sunday 09 July 2006 09:54, Pavel Machek wrote:
> > Hi!
> >
> > > > > > It's only too slow on swsusp. With Suspend2, I regularly suspend
> > > > > > 1GB images on both my desktop and laptop machines. I agree that it
> > > > > > might be slower on a
> > > >
> > > > uswsusp is as fast as suspend2. It does same LZF compression.
> > >
> > > I agree for uncompressed images - I tried timing the writing of the image
> > > yesterday. I'm not sure about LZF though, because I couldn't get it to
> > > resume. I'd be interested to see it really be as fast as suspend2 with
> > > compression.
> >
> > Is there any way to help you? I assume normal swsusp resumes okay so
> > it is not driver problem?
> 
> That's right. I'll see if I can figure it out tomorrow, Lord willing. I 
> have /dev/snapshot in my initrd but it gives that prompt asking for the 
> device name. By the way, will it sit there foreever, or does that have a 
> timeout?

You also need to have /dev/<your_resume_partition_name> as well as
/etc/suspend.conf in your initrd.

Plaese create an initrd with 'make install-resume-initrd' (it will create
the 'resume-initrd' file in /boot and make a copy of the existing one, if any)
and see what's there.

Rafael
