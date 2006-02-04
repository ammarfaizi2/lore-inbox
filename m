Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWBDLDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWBDLDe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 06:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWBDLDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 06:03:34 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:17568 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932192AbWBDLDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 06:03:33 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Sat, 4 Feb 2006 11:58:59 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060204090112.GJ3291@elf.ucw.cz> <200602041954.22484.nigel@suspend2.net>
In-Reply-To: <200602041954.22484.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602041159.00326.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 04 February 2006 10:54, Nigel Cunningham wrote:
> On Saturday 04 February 2006 19:01, Pavel Machek wrote:
> > On So 04-02-06 11:20:54, Nigel Cunningham wrote:
> > > Hi Pavel.
> > >
> > > On Friday 03 February 2006 21:44, Pavel Machek wrote:
> > > > [Pavel is willing to take patches, as his cooperation with Rafael
> > > > shows, but is scared by both big patches and series of 10 small
> > > > patches he does not understand. He likes patches removing code.]
> > >
> > > Assuming you're refering to the patches that started this thread, what
> > > don't you understand? I'm more than happy to explain.
> >
> > For "suspend2: modules support", it is pretty clear that I do not need
> > or want that complexity. But for "refrigerator improvements", I did
> 
> ... and yet you're perfectly happy to add the complexity of sticking half 
> the code in userspace. I don't think I'll ever dare to try to understand 
> you, Pavel :)
> 
> > not understand which parts are neccessary because of suspend2
> > vs. swsusp differences, and if there is simpler way towards the same
> > goal. (And thanks for a stress hint...)
> 
> I think virtually everything is relevant to you.

My personal view is that:
1) turning the freezing of kernel threads upside-down is not necessary and
would cause problems in the long run,
2) the todo lists are not necessary and add a lot of complexity,
3) trying to treat uninterruptible tasks as non-freezeable should better be
avoided (I tried to implement this in swsusp last year but it caused vigorous
opposition to appear, and it was not Pavel ;-))

> A couple of possible  exceptions might be (1) freezing bdevs,
> because you don't care so much about making xfs really sync and really
> stop it's activity

As I have already stated, in my view this one is at least worth considering
in the long run.

> and (2) the  ability to thaw kernel space without thawing userspace. I want
> this for eating memory, to avoid deadlocking against kjournald etc. I haven't 
> checked carefully as to why you don't need it in vanilla.

Because it does not deadlock?  I will say we need this if I see a testcase
showing such a deadlock clearly.

Greetings,
Rafael

