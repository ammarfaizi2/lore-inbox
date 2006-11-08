Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161693AbWKHXro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161693AbWKHXro (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161750AbWKHXro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:47:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19943 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161693AbWKHXro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:47:44 -0500
Date: Thu, 9 Nov 2006 00:47:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, pm list <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [linux-pm] S2RAM and PCI quirks
Message-ID: <20061108234729.GB23816@elf.ucw.cz>
References: <1163000705.23956.18.camel@localhost.localdomain> <1163000924.3138.342.camel@laptopd505.fenrus.org> <1163001711.23956.30.camel@localhost.localdomain> <200611082218.55052.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611082218.55052.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-11-08 22:18:54, Rafael J. Wysocki wrote:
> On Wednesday, 8 November 2006 17:01, Alan Cox wrote:
> > Ar Mer, 2006-11-08 am 16:48 +0100, ysgrifennodd Arjan van de Ven:
> > > at the same time I'm not 100% convinced it's ok to always run all quirks
> > > at resume, for one the difference is that there now is a driver active
> > > owning the device... Almost sounds like having a per quirk flag stating
> > > "run at resume" is needed ;-(
> > 
> > We probably need a quirk class for resume in this situation. The kind of
> > things that worry me if we are not doing the quirk handling, and what I
> > suspect happened in the case I looked at are that chipset bug
> > workarounds did not get restored, and in this case the older VIA chipset
> > involved then corrupted DMA streams and trashed the users disk.
> 
> Now that would explain why many boxes resume from disk correctly, but don't
> resume from RAM by any means.

Well, there are other good reasons, too. (suspend-to-disk resume works
with hardware in mostly-initialized state, while suspend-to-ram resume
works with hardware in mostly-weird state). Yes, per-quirk "run me on
resume-from-ram" is probably the way forward.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
