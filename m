Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUILVPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUILVPZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 17:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUILVPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 17:15:25 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:17052 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262085AbUILVPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 17:15:23 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: swsusp: kill crash when too much memory is free
Date: Sun, 12 Sep 2004 23:16:41 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz> <200409111150.28457.rjw@sisk.pl> <20040912204255.GA3168@elf.ucw.cz>
In-Reply-To: <20040912204255.GA3168@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409122316.41601.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 of September 2004 22:42, Pavel Machek wrote:
> Hi!
> 
> > > Hmm, I do not know what nForce3 is (it should use better name at the
> > > minimum), but that driver probably needs some work.
> > 
> > It is the sound chip (ie snd-intel8x0).  If I unload it after resume, 
> > everything's fine and dandy.  Moreover, if I unload it before suspend, the 
> > box wakes up with no problems (of course, I have to unload the other 
modules 
> > too, as I said before).
> > 
> > However, I think the problem is with the hardware, not with the driver: if 
the 
> > sound driver is unloaded before suspend and loaded again after resume, the 
> > box behaves as though it were loaded all the time (ie IRQ #5 goes mad).  
Are 
> > there any boot options that may help get around this?
> 
> Hmm, I do not think it is hardware problem.

You're right, it isn't.  If the kernel is booted with pci=routeirq, the 
problem goes away, as I've said already.

> Does snd-intel8x0 have any suspend/resume support?

It seems it doesn't, but frankly I haven't looked at the code.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
