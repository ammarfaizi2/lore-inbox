Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWESNmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWESNmQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 09:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWESNmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 09:42:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40414 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932309AbWESNmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 09:42:14 -0400
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
From: Thomas Renninger <trenn@suse.de>
Reply-To: trenn@suse.de
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: "Yu, Luming" <luming.yu@intel.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>,
       Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de,
       mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>,
       Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
In-Reply-To: <E1FHa8k-00015b-M5@approximate.corpus.cam.ac.uk>
References: <E1FHa8k-00015b-M5@approximate.corpus.cam.ac.uk>
Content-Type: text/plain
Organization: Novell/SUSE
Date: Fri, 19 May 2006 15:44:17 +0200
Message-Id: <1148046258.9319.441.camel@queen.suse.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 00:26 -0500, Sanjoy Mahajan wrote:
> [Re: bugme #5989, head no longer hanging in shame]
> 
> From: "Yu, Luming" <luming.yu@intel.com>
> > I suggest you to retest, and post dmesg with UN-modified BIOS.
> 
> I'm now running/testing an unmodified DSDT with 2.6.16-rc5.  For a while
> I had no S3 hangs, but I just noticed them again.  The error is the same
> as with the modified DSDT (with slightly different offsets):
> 
> exregion-0185 [36] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFFC0
> exregion-0185 [36] ex_system_memory_space: system_memory 1 (32 width) Address=0000000023FDFFC0
> exregion-0290 [36] ex_system_io_space_han: system_iO 1 (8 width) Address=00000000000000B2
> 
> repeated endlessly.

This sounds like the problem Daniel had on his Samsung P35 recently.
He could fix it by getting rid of some asus_unhide_smbus stuff or the
otherway around, adding asus_unhide_smbus quirks in the S3 resume code.

This thread was recently posted on lkml:
Re: [patch] smbus unhiding kills thermal management

Here are some more details, for me that sounds related...:
https://bugzilla.novell.com/show_bug.cgi?id=173420

     Thomas

