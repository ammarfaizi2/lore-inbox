Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284917AbRLRUIn>; Tue, 18 Dec 2001 15:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284916AbRLRUI3>; Tue, 18 Dec 2001 15:08:29 -0500
Received: from ausxc07.us.dell.com ([143.166.227.166]:11046 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S284917AbRLRUIO>; Tue, 18 Dec 2001 15:08:14 -0500
Message-ID: <71714C04806CD5119352009027289217022C4115@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, nils@kernelconcepts.de,
        giometti@ascensit.com, pb@nexus.co.uk, chowes@vsol.net, gorgo@itc.hu,
        info@itc.hu, lethal@chaoticdreams.org, woody@netwinder.org,
        johnsonm@redhat.com
Subject: RE: [CFT][PATCH] watchdog nowayout and timeout module parameters
Date: Tue, 18 Dec 2001 14:08:08 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Timeout has been moved to an ioctl more by other diffs so Im not sure
> timeout= is too important

Of the seven drivers I added this parm to, six do not offer such a method
via ioctl:
eurotechwdt.c provides WDIOC_SETTIMEOUT.
acquirewdt.c, advantechwdt.c, ib700wdt.c, pcwd.c, wdt.c, wdt_pci.c do not
provide a set timeout ioctl.

These already offer a timeout parm, but no set timeout ioctl:
i810-tco.c, softdog.c, wdt285.o

The other drivers I didn't add timeout parm to anyhow, but they don't have a
set timeout ioctl either:
machzwd.c, mixcomwd.c, shwdt.c, wdt977.c

Unless there are strong objections or a push to make it an ioctl everywhere
instead/also, I'd like to leave it in.

> Rest looks good

Thanks for reviewing and approving.  14 drivers modified, 5 drivers
approved, one investigating, two email addresses invalid, leaving 6 to hear
from.

-Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
#1 US Linux Server provider with 24.5% (IDC Dec 2001)
#2 Worldwide Linux Server provider with 18.2% (IDC Dec 2001)
