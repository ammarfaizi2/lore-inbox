Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbTIVTH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbTIVTH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:07:27 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:49323 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262339AbTIVTHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:07:25 -0400
Date: Mon, 22 Sep 2003 12:07:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: [PATCH] Add 'make uImage' for PPC32
Message-ID: <20030922190723.GN7443@ip68-0-152-218.tc.ph.cox.net>
References: <20030922182928.GM7443@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922182928.GM7443@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 11:29:28AM -0700, Tom Rini wrote:

> Hello.  The following BK patch adds support for a 'uImage' target on
> PPC32.  This will create an image for the U-Boot (and formerly
> PPCBoot) firmware.  The patch adds a scripts/mkuboot.sh as a wrapper for
> the U-Boot mkimage program.  We put mkuboot.sh into scripts/ because
> U-Boot works on a number of other platforms, and it's likely that they
> will add a uImage target at some point.  Please apply.

And since I don't use U-Boot I didn't fully test this until I did the
2.6 forward port (coming soon), so the following is also needed to get
all of the dependancies correct.  Please apply.

-- 
Tom Rini
http://gate.crashing.org/~trini/

This BitKeeper patch contains the following changesets:
trini@kernel.crashing.org|ChangeSet|20030922190523|00073

# ID:	torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
# User:	trini
# Host:	kernel.crashing.org
# Root:	/home/trini/work/kernel/pristine/linux-2.4

# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
trini@kernel.crashing.org|ChangeSet|20030922180348|00070
D 1.1133 03/09/22 12:05:23-07:00 trini@kernel.crashing.org +1 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c PPC32: Fix dependancies on uImage.
K 73
P ChangeSet
------------------------------------------------

0a0
> torvalds@athlon.transmeta.com|arch/ppc/boot/Makefile|20020205174025|54177|a1ccc61f9b0e318d trini@kernel.crashing.org|arch/ppc/boot/Makefile|20030922190513|45691

== arch/ppc/boot/Makefile ==
torvalds@athlon.transmeta.com|arch/ppc/boot/Makefile|20020205174025|54177|a1ccc61f9b0e318d
trini@kernel.crashing.org|arch/ppc/boot/Makefile|20030922180241|43396
D 1.12 03/09/22 12:05:13-07:00 trini@kernel.crashing.org +2 -2
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Make uImage depend on $(MKIMAGE) and don't use $< but
c images/vmlinux.gz instead.
K 45691
O -rw-rw-r--
P arch/ppc/boot/Makefile
------------------------------------------------

D65 1
I65 1
uImage: $(MKIMAGE) images/vmlinux.gz
D69 1
I69 1
	-d images/vmlinux.gz images/vmlinux.UBoot

# Patch checksum=258c7251
