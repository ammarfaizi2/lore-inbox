Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTEQIDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 04:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbTEQIDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 04:03:41 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:17599 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261300AbTEQIDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 04:03:40 -0400
Date: Sat, 17 May 2003 10:16:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Lionel.Bouton@inet6.fr,
       alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Support for SiS 961/961B/962/963/630S/630ET/633/733 IDE
Message-ID: <20030517101603.B25569@ucw.cz>
References: <20030516143021.A17346@ucw.cz> <Pine.SOL.4.30.0305161903590.16125-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.30.0305161903590.16125-100000@mion.elka.pw.edu.pl>; from B.Zolnierkiewicz@elka.pw.edu.pl on Fri, May 16, 2003 at 07:14:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 07:14:36PM +0200, Bartlomiej Zolnierkiewicz wrote:

> Good job, but...
> 
> On Fri, 16 May 2003, Vojtech Pavlik wrote:
> > And while doing the changes I did also some cleanups, mainly removing a
> > bunch of debug code that doesn't seem very useful when lspci does the
> > same job. And removing the config_drive_xfer_rate in favor of functions
> > from ide-timing.h.
> 
> Debug code in fe. SiS IDE driver does the same as lspci given you get to
> the point you can run lspci. Dumping of PCI conf regs should be moved to
> generic IDE PCI code as it might be useful for other IDE PCI drivers.

Yes, that would be useful. 

> Removing config_drive_xfer_rate() is bad,
> fe. you don't check for bad drives now.

True. That needs to be added to ide_find_best_mode in ide-timing.h.
Which needs to be converted to ide-timing.c.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
