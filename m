Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130989AbQL3RBU>; Sat, 30 Dec 2000 12:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131178AbQL3RBK>; Sat, 30 Dec 2000 12:01:10 -0500
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:51640 "EHLO
	smtprelay3.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S130989AbQL3RA6>; Sat, 30 Dec 2000 12:00:58 -0500
Date: Sat, 30 Dec 2000 11:31:53 -0500 (EST)
From: "Steven N. Hirsch" <shirsch@adelphia.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
In-Reply-To: <200012132215.eBDMFas35908@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.21.0012301114250.25769-100000@pii.fast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Justin T. Gibbs wrote:

> daptec SCSI HBA device driver for the Linux Operating System
> To: linux-scsi@vger.kernel.org
> cc:
> Fcc: +outbox
> Subject: Adaptec AIC7XXX v6.0.6 BETA Released
> -------
> After several months of testing and refinement, the Adaptec 
> sponsored aic7xxx driver is now entering Beta testing.  Although
> still missing domain validation and the last bits of cardbus
> support, there are no known issues with the driver.  I would
> encourage all users of card supported by this driver to try the
> new code and submit feedback.  Patches for late 2.2.X, 2.3.99
> and 2.4.0 are provided in the driver distribution.  For those
> of you building the driver as a module, take note that the module
> name is now "aic7xxx_mod" rather than "aic7xxx".
> 
> As always, the most recent distribution is available here:
> 
> http://people.FreeBSD.org/~gibbs/linux/

Justin,

Although your driver has worked fine otherwise, I discovered today that it
renders my Seagate/Conner DDS-2 drive inoperative.  Any and all attempts
at accessing the device (e.g. making tar archive, 'mt -f /dev/st0 status',
etc.) result in:

st0:  Error 10000 (sugg. bt 0x0, driver bt 0x0, host bt 0x1).

The platform is a Pentium 166 with on-board aic7880 controller.

If I revert back to Doug Ledford's 5.1.31 driver, everything is fine.

Any insights or things you'd like me to try?

Steve



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
