Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272528AbTGaQMJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272516AbTGaQJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:09:04 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:51844 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S272513AbTGaQHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:07:02 -0400
Date: Thu, 31 Jul 2003 18:06:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
Message-ID: <20030731160643.GA342@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net> <20030731094749.GB464@elf.ucw.cz> <3F291A0F.1050406@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F291A0F.1050406@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>The "initiators" all talk to _both_ infrastructures, but they
> >>don't talk to the driver model stuff in the same way.  For
> >>example, on suspend:

> >Where does acpi call pm_*()? It seems like it does not and it seems
> >like a bug to me.
> 
> Doesn't; it showed up in a 'grep' that I should have examined
> more closely.  Sorry!  But both swsusp and APM have the "using
> both registration schemes" issue (consistency matters here).
> 
> Why does it seem like a bug -- because it's using only the "new"
> infrastructure, while there are still a few drivers that only
> register to the old one?  

Yes.

> I'd rather see those drivers (about
> a dozen) have compile time #ifdef CONFIG_PM #warnings, and call
> them the bug...

I guess I like that, too.. But at this point whole PCI relies on
old-style pm_*(); that needs to be fixed, first.
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
