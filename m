Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbTGaVcH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269612AbTGaVaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:30:55 -0400
Received: from AMarseille-201-1-5-189.w217-128.abo.wanadoo.fr ([217.128.250.189]:26919
	"EHLO gaston") by vger.kernel.org with ESMTP id S274888AbTGaV3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:29:52 -0400
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <3F291B9E.10109@pacbell.net>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org>
	 <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net>
	 <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net>
	 <20030731094231.GA464@elf.ucw.cz>  <3F291B9E.10109@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059686941.2417.161.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 31 Jul 2003 23:29:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 15:37, David Brownell wrote:
> Pavel Machek wrote:
> 
> >>All of which is a roundabout way of adding to what I
> >>said:  the PM infrastructure USB will need to rely on
> >>seems like it needs polishing yet!  :)
> > 
> > 
> > Do you need vetoing? Otherwise it should be ready, except for APM.
> 
> USB drivers don't talk suspend/resume yet, so they
> won't notice missing features there.  Regressions
> are a different story though.
> 
> But I can imagine that usb-storage (or is that SCSI?)
> might want to veto suspending devices that are being
> used for some kinds of i/o.  Eventually it should exist.

The only place where a kernel driver may veto is when doing things
like firmware flashing.

If you want to veto suspend when burning a CD, it's userland policy. We
still need, I beleive, to define/write a proper userland-side API for
all these with the daemon that goes with it. That will be next step once
we have the kernel side working properly ;)

Ben.

