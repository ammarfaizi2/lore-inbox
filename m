Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVBRAOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVBRAOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 19:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVBRAOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 19:14:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:36246 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261259AbVBRAHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 19:07:22 -0500
X-Authenticated: #26200865
Message-ID: <42153227.9060800@gmx.net>
Date: Fri, 18 Feb 2005 01:09:11 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: vojtech@suse.cz, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, seife@suse.de, rjw@sisk.pl,
       Len Brown <len.brown@intel.com>
Subject: Re: [ACPI] Call for help: list of machines with working S3 (fwd)
References: <20050217232719.GB12638@elf.ucw.cz>
In-Reply-To: <20050217232719.GB12638@elf.ucw.cz>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek schrieb:
> 
>>>I'm not sure if you can push the whole industry at once.
>>
>>The goal is to know what to tell the system vendors
>>interested in supporting Linux what they should do
>>with their BIOS on future platforms.
>>
>>I believe our message should be:
>>1. BIOS should save/restore video in S3
> 
> Actually, that'd expect too much of BIOS writers. I believe right
> solution is "POST video as you do during normal boot in S3 resume".

Why not leave the choice to the BIOS writers? If some are able to
save/restore video state by themselves, we shoudln't stop them.
As long as the state after resume accepts setting the mode without
lockup, we should be fine.


>>2. Use Intel's ACPICA ASL compiler -- if not for production,
>>then at least as a static source code checker for validation.
> 
> 
> 3. Try to boot linux (here's live cd). If it complains about bios bugs
> (dmesg | grep ...), try to see if it is not indeed your bug.

That could even be automated more. A live cd which boots, performs
a few tests, displays the results on screen and offers an option
to save these results to usbstick/network/disk/whatever.
After saving the boot results, it will perform a S3 suspend and
resume and display/save the results of that, too. If Intel have
enough money, they could provide the functionality on a hard
disk and it would have the benefit that S4 could be tested as well.
If the disk has a FAT32 partition, the results can be saved there.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
