Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbSLEWcq>; Thu, 5 Dec 2002 17:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267565AbSLEWcq>; Thu, 5 Dec 2002 17:32:46 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11027 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267564AbSLEWcp>; Thu, 5 Dec 2002 17:32:45 -0500
Date: Thu, 5 Dec 2002 23:40:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.50, ACPI] link error
Message-ID: <20021205224019.GH7396@atrey.karlin.mff.cuni.cz>
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <200212031007.01782.EricAltendorf@orst.edu> <87znrn3q92.fsf@gswi1164.jochen.org> <200212031247.07284.EricAltendorf@orst.edu> <20021205173145.GB731@elf.ucw.cz> <3DEFD17D.4090809@pobox.com> <20021205222431.GB7396@atrey.karlin.mff.cuni.cz> <3DEFD2CE.4070805@pobox.com> <20021205223353.GE7396@atrey.karlin.mff.cuni.cz> <3DEFD54A.8050306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEFD54A.8050306@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>Yes, there are about 10 patches to fix it floating around... I just
> >>>hope linus takes one of them. (Fix is make ACPI_SLEEP depend on
> >>>swsusp).
> >>
> >>
> >>I haven't seen the patch, but does it make sense for hardware suspend to 
> >>depend on software suspend?
> >>
> >>IMO there should be a common core (CONFIG_SUSPEND?), not force ACPI to 
> >>depend on swsusp.  That way you get the _least_ common denominator, not 
> >>the union of two sets.
> >
> >
> >Feel free to fix that, but as swsusp is needed for S4, anyway, I do not
> >see big need to do that.
> 
> 
> Why should I fix your fix?
> 
> Doesn't that imply your fix is broken to begin with?

ACPI/S4 support needs swsusp. ACPI/S3 needs big part of
swsusp. Splitting CONFIG_ACPI_SLEEP to S3 and S4 part seems like
overdesign to me, OTOH if you do the work it is okay with me.

								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
