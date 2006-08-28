Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWH1BoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWH1BoO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 21:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWH1BoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 21:44:13 -0400
Received: from mxsf38.cluster1.charter.net ([209.225.28.165]:48573 "EHLO
	mxsf38.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932154AbWH1BoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 21:44:12 -0400
X-IronPort-AV: i="4.08,174,1154923200"; 
   d="scan'208"; a="442056071:sNHT69619718"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17650.19049.326213.978165@stoffel.org>
Date: Sun, 27 Aug 2006 21:44:09 -0400
From: "John Stoffel" <john@stoffel.org>
To: "John Stoffel" <john@stoffel.org>
Cc: Andrew Morton <akpm@osdl.org>, "Miles Lane" <miles.lane@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.18-rc4-mm3 -- ACPI Error (utglobal-0125): Unknown exception
 code: 0xFFFFFFEA [20060707]
In-Reply-To: <17649.47572.627874.371564@stoffel.org>
References: <a44ae5cd0608262356j29c0234cl198fb207bcad383d@mail.gmail.com>
	<20060827001437.ec4f7a7a.akpm@osdl.org>
	<17649.47572.627874.371564@stoffel.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John Stoffel <john@stoffel.org> writes:

Just to give some more information, I tried upping the BIOS on my
Rocket 133 (HPT302) card from 1.21 to 1.22, and it's taken me most of
the day to recover.  The system would boot, then hang at the HPT
BIOS... and it looked like to toasted my Dell's bios as well.  So I
ended up a) upping the DELL Precision 610 Dual Xeon 550mhz from A10 to
A11 BIOS, and b) moving the HPT302 card to another system and booting
of flopyy and downgrading from 1.22 to 1.21, where it then started
working again for me.

Sigh... looks like for now that I'm going to steer clear of the libata
drivers.  Oh well, let me know when to try them again, since
2.6.18-rc4-mm3 doesn't do the trick.  Why, I dunno, but it looks like
some sort of IRQ handling conflicts.  

Maybe I'll try pulling all my USB drivers and seeing how that works,
since it looks like it was a conflict in there somewhere.  

Please let me know if I can provide more details.  I've dropped back
to 2.6.17, since that's the only recent version which seems to work
for me, none of the 2.6.18-rc* have so far.

John
