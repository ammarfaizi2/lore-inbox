Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264504AbTEPRC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 13:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbTEPRC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 13:02:27 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8624 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264504AbTEPRC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 13:02:26 -0400
Date: Fri, 16 May 2003 19:14:36 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: <Lionel.Bouton@inet6.fr>, <alan@lxorguk.ukuu.org.uk>,
       <marcelo@conectiva.com.br>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Support for SiS 961/961B/962/963/630S/630ET/633/733 IDE
In-Reply-To: <20030516143021.A17346@ucw.cz>
Message-ID: <Pine.SOL.4.30.0305161903590.16125-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Good job, but...

On Fri, 16 May 2003, Vojtech Pavlik wrote:
> And while doing the changes I did also some cleanups, mainly removing a
> bunch of debug code that doesn't seem very useful when lspci does the
> same job. And removing the config_drive_xfer_rate in favor of functions
> from ide-timing.h.

Debug code in fe. SiS IDE driver does the same as lspci given you get to
the point you can run lspci. Dumping of PCI conf regs should be moved to
generic IDE PCI code as it might be useful for other IDE PCI drivers.

Removing config_drive_xfer_rate() is bad,
fe. you don't check for bad drives now.

Regards,
--
Bartlomiej


