Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264517AbTI2TN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbTI2TN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:13:58 -0400
Received: from web40902.mail.yahoo.com ([66.218.78.199]:25657 "HELO
	web40902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264517AbTI2TNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:13:54 -0400
Message-ID: <20030929191352.10470.qmail@web40902.mail.yahoo.com>
Date: Mon, 29 Sep 2003 12:13:52 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: [BUG] Defunct event/0 processes under 2.6.0-test6-mm1
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030929120910.A6895@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Wright,

--- Chris Wright <chrisw@osdl.org> wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > Bradley Chapman <kakadu_croc@yahoo.com> wrote:
> > >
> > > I am experiencing defunct event/0 kernel daemons under 2.6.0-test6-mm1
> > >  with synaptics_drv 0.11.7, Dmitry Torokhov's gpm-1.20 with synaptics
> > >  support, and XFree86 4.3.0-10. Moving the touchpad in either X or with
> > >  gpm causes defunct event/0 processes to be created. 
> > 
> > Defunct is odd.  Have you run `dmesg' to see if the kernel oopsed?
> > 
> > You could try reverting synaptics-reconnect.patch, and then
> serio-reconnect.patch from
> 
> Andrew, I wonder if this isn't caused by the call_usermodehelper patch.
> Looks like you were right ;-)

He is right. I reverted call_usermodehelper-retval-fix-2.patch and everything
works again. Why would that break the source of events/0 and hotplug?

I'd post a link to my reponse but the USSG archive is slow ;-)

> 
> thanks,
> -chris

Brad


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
