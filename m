Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbTI2Rq0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263967AbTI2Rou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:44:50 -0400
Received: from users.linvision.com ([62.58.92.114]:62439 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263969AbTI2Rlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:41:31 -0400
Date: Mon, 29 Sep 2003 19:41:27 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, cesarb@nitnet.com.br
Subject: Re: [Bug 1284] New: Asus P5AB broken BIOS reading ESCD
Message-ID: <20030929174127.GD26491@bitwizard.nl>
References: <42150000.1064850644@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42150000.1064850644@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 08:50:44AM -0700, Martin J. Bligh wrote:
>            Summary: Asus P5AB broken BIOS reading ESCD
>     Kernel Version: 2.6.0-test6
>             Status: NEW
>           Severity: normal
>              Owner: mbligh@aracnet.com
>          Submitter: cesarb@nitnet.com.br
> 
> 
> Distribution: Debian testing/unstable
> Hardware Environment: Asus P5AB
> Software Environment:
> Problem Description:
> 
> Trying to read /proc/bus/pnp/escd causes an oops. Looks like the PnPBIOS is
> broken. However, it's not exploding_pnp_bios, since only reading the escd causes
> it (the boot probe works fine).
>
> I think a new function should be added to the DMI blacklist to block trying to
> read the ESCD.

[...]

> DMI:
> # dmidecode 2.2
> Legacy DMI 2.0 present.
> 29 structures occupying 946 bytes.
> Table at 0x000F545A.
> Handle 0x0000
> 	DMI type 0, 18 bytes.
> 	BIOS Information
> 		Vendor: Award Software, Inc.
> 		Version: ASUS P5A-B ACPI BIOS Revision 1004 .............................

FWIW: I used to have a similar board (Asus P5A, it actually died a week
ago, so I can't check anything anymore). Never tried 2.6 on it, but I
know it had a flakey PnPBIOS implementation: if you put in a Sound
Blaster AWE64 Gold, you couldn't use the floppy drive anymore. The
latest "Y2K compliant" BIOS (revision 1.005 IIRC) fixed that, it might
also fix this particular bug.

(Asus website seems to be broken, I get a "runtime error" from their
web server when I want to get a list of downloads, so I have no idea if
you have the latest BIOS right now :-/ )


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost?!
| Stay calm and contact Harddisk-recovery.com!
