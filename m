Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbTI2WWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 18:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbTI2WWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 18:22:45 -0400
Received: from salzburg.nitnet.com.br ([200.157.92.10]:50105 "EHLO
	nat.cesarb.net") by vger.kernel.org with ESMTP id S262989AbTI2WWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 18:22:41 -0400
Date: Mon, 29 Sep 2003 19:22:18 -0300
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 1284] New: Asus P5AB broken BIOS reading ESCD
Message-ID: <20030929222218.GE27908@flower.home.cesarb.net>
References: <42150000.1064850644@[10.10.2.4]> <20030929174127.GD26491@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929174127.GD26491@bitwizard.nl>
User-Agent: Mutt/1.5.4i
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 07:41:27PM +0200, Erik Mouw wrote:
> On Mon, Sep 29, 2003 at 08:50:44AM -0700, Martin J. Bligh wrote:
> >            Summary: Asus P5AB broken BIOS reading ESCD
> >     Kernel Version: 2.6.0-test6
> >             Status: NEW
> >           Severity: normal
> >              Owner: mbligh@aracnet.com
> >          Submitter: cesarb@nitnet.com.br
> > 
> > 
> > Distribution: Debian testing/unstable
> > Hardware Environment: Asus P5AB
> > Software Environment:
> > Problem Description:
> > 
> > Trying to read /proc/bus/pnp/escd causes an oops. Looks like the PnPBIOS is
> > broken. However, it's not exploding_pnp_bios, since only reading the escd causes
> > it (the boot probe works fine).
> >
> > I think a new function should be added to the DMI blacklist to block trying to
> > read the ESCD.
> 
> [...]
> 
> > DMI:
> > # dmidecode 2.2
> > Legacy DMI 2.0 present.
> > 29 structures occupying 946 bytes.
> > Table at 0x000F545A.
> > Handle 0x0000
> > 	DMI type 0, 18 bytes.
> > 	BIOS Information
> > 		Vendor: Award Software, Inc.
> > 		Version: ASUS P5A-B ACPI BIOS Revision 1004 .............................
> 
> FWIW: I used to have a similar board (Asus P5A, it actually died a week
> ago, so I can't check anything anymore). Never tried 2.6 on it, but I
> know it had a flakey PnPBIOS implementation: if you put in a Sound
> Blaster AWE64 Gold, you couldn't use the floppy drive anymore. The
> latest "Y2K compliant" BIOS (revision 1.005 IIRC) fixed that, it might
> also fix this particular bug.
> 
> (Asus website seems to be broken, I get a "runtime error" from their
> web server when I want to get a list of downloads, so I have no idea if
> you have the latest BIOS right now :-/ )
> 

The latest BIOS (a beta one) still has the same problem. Also, it breaks
the main timer (for instance, vmstat 1 takes 2-3 seconds between lines,
and the kernel complains about a broken TSC on boot).

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
