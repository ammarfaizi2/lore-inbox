Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWJJKld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWJJKld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 06:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWJJKld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 06:41:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:727 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932320AbWJJKlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 06:41:32 -0400
Subject: Re: 2.6.18 suspend regression on Intel Macs
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Riss <frederic.riss@gmail.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com
In-Reply-To: <20061010103910.GD31598@elf.ucw.cz>
References: <1160417982.5142.45.camel@funkylaptop>
	 <20061010103910.GD31598@elf.ucw.cz>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 10 Oct 2006 12:41:28 +0200
Message-Id: <1160476889.3000.282.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 12:39 +0200, Pavel Machek wrote:
> Hi!
> 
> > Well, I'm not sure it qualifies as a regression, because AFAIK no
> > official kernels can s2ram/resume Intel Macs correctly out of the box.
> ...
> 
> > There has already been some discussion about the SCI_EN ACPI control bit
> > not being set when the Mactel boxes come out of suspend to ram. 
> > http://marc.theaimsgroup.com/?l=linux-acpi&m=114957637501557&w=2
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=115005083610700&w=2
> > http://bugme.osdl.org/show_bug.cgi?id=6670
> > 
> > The symptom is:
> >     irq 9: nobody cared (try booting with the "irqpoll" option)
> >     Disabling IRQ #9
> > when the system comes out of sleep, making ACPI non-functional.
> > 
> > Two days after having released 2.6.17, Linus commited a fix for this
> > issue in his tree (commit 5603509137940f4cbc577281cee62110d4097b1b):
> 
> If fix was in 2.6.18-gitX, yes, that probably counts as a regression

"fix" for some value of the word.
The problem is that this is very much against the spec, and also quite
likely breaks a bunch of machines...

If we do this we probably should at least key this of some DMI
identification for the mac mini..


