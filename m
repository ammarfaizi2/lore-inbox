Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVKNPdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVKNPdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVKNPdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:33:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26601 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751153AbVKNPdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:33:44 -0500
Date: Mon, 14 Nov 2005 13:10:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ian Campbell <ijc@hellion.org.uk>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org,
       Todd Poynor <tpoynor@mvista.com>
Subject: Re: latest mtd changes broke collie
Message-ID: <20051114121006.GA1855@elf.ucw.cz>
References: <20051110103823.GB2401@elf.ucw.cz> <1131619903.27347.177.camel@baythorne.infradead.org> <20051110105954.GE2401@elf.ucw.cz> <1131621090.27347.184.camel@baythorne.infradead.org> <20051110224158.GC9905@elf.ucw.cz> <4373DEB4.5070406@mvista.com> <20051111001617.GD9905@elf.ucw.cz> <1131692514.3525.41.camel@localhost.localdomain> <20051112213355.GA4676@elf.ucw.cz> <1131878117.23932.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131878117.23932.3.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I tried this one. Size 0xc0000 is reported as a "bootloader" during
> > boot. 
> > 
> > [Plus I get a warning from jffs2 that flashsize is not aligned to
> > erasesize. Then I get lot of messages that empty flash at XXX ends at
> > XXX.]
> 
> What erase size did you end up using? Is 0xc0000 a multiple of it?

I ended up using ERASEINFO(0x10000,64), but I should probably be using
ERASEINFO(0x40000,16).

> > +	subdev->mtd->unlock(subdev->mtd, 0xc0000, subdev->mtd->size);
> 
> Probably unrelated to the actual problems, but shouldn't that be
> subdev->mtd->size - 0xc0000 at the end?

Fixed, thanks.
								Pavel
-- 
Thanks, Sharp!
