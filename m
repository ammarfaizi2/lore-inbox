Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWHLTMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWHLTMr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 15:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWHLTMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 15:12:47 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:48527 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030253AbWHLTMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 15:12:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend to disk on i386
Date: Sat, 12 Aug 2006 21:11:37 +0200
User-Agent: KMail/1.9.3
Cc: "Pavel Machek" <pavel@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "Linux ACPI" <linux-acpi@vger.kernel.org>
References: <200608091426.31762.rjw@sisk.pl> <200608102251.20707.rjw@sisk.pl> <4807377b0608121208g1bf4eebasc51f99fe00889bd7@mail.gmail.com>
In-Reply-To: <4807377b0608121208g1bf4eebasc51f99fe00889bd7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608122111.37262.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 August 2006 21:08, Jesse Brandeburg wrote:
> On 8/10/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > > > CONFIG_PM_TRACE=y will scrog your CMOS clock each time you suspend.
> > > > >
> > > > > Oh dear.  Of course it's set in my .config.  Thanks a lot for this hint. :-)
> > > > >
> > > > > BTW, it's a dangerous setting, because some drivers get mad if the time after
> > > > > the resume appears to be earlier than the time before the suspend.  Also the
> > > > > timer .suspend/.resume routines aren't prepared for that.
> > > >
> > > > Its config option should just go away. People comfortable using *that*
> > > > should just edit some header file. Rafael, could you do patch doing
> > > > something like that?
> 
> I've seen this problem too, thought it was only mm.
> Should the problem go away if I disable CONFIG_PM_TRACE?

Yes.
