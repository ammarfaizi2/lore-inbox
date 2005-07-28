Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVG1IlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVG1IlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVG1Iis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:38:48 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:44247 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261370AbVG1IiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 04:38:16 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [ACPI] Re: [Alsa-devel] [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (1/2)
Date: Thu, 28 Jul 2005 10:43:13 +0200
User-Agent: KMail/1.8.1
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org
References: <200507261247.05684.rjw@sisk.pl> <20050727205249.GA708@openzaurus.ucw.cz> <s5hr7djtkvo.wl%tiwai@suse.de>
In-Reply-To: <s5hr7djtkvo.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507281043.14697.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 28 of July 2005 10:06, Takashi Iwai wrote:
> At Wed, 27 Jul 2005 22:52:49 +0200,
> Pavel Machek wrote:
> > 
> > Hi!
> > 
> > > > The following patch adds free_irq() and request_irq() to the suspend and
> > > > resume, respectively, routines in the snd_intel8x0 driver.
> > > 
> > > The patch looks OK to me although I have some concerns.
> > > 
> > > - The error in resume can't be handled properly.
> > > 
> > >   What should we do for the error of request_irq()?
> > > 
> > > - Adding this to all drivers seem too much.
> > 
> > There's probably no other way. Talk to Len Brown.
> > 
> > >   We just need to stop the irq processing until resume, so something
> > >   like suspend_irq(irq, dev_id) and resume_irq(irq, dev_id) would be
> > >   more uesful?
> > 
> > Its more complex than that. Irq numbers may change during resume.
> 
> Hmm, then the patch looks wrong.  It assumes that the irq number is
> as same as before suspend.

Well, that''s the theory, but frankly I don't see a practical reason.  I have never
seen this happening.  Practically, for this to happen, you'll have to reconfigure
the BIOS accross suspend/resume which is dangerous anyway.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
