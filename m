Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVBQUfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVBQUfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVBQUed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:34:33 -0500
Received: from imap.gmx.net ([213.165.64.20]:57820 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262318AbVBQUce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:32:34 -0500
X-Authenticated: #26200865
Message-ID: <4214FFCE.4080703@gmx.net>
Date: Thu, 17 Feb 2005 21:34:22 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <len.brown@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de,
       rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz> <1108621005.2096.412.camel@d845pe> <1108638021.4085.143.camel@tyrosine> <4214C3B8.30502@gmx.net> <20050217195456.GA5963@openzaurus.ucw.cz>
In-Reply-To: <20050217195456.GA5963@openzaurus.ucw.cz>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek schrieb:
> 
>>>to reinitialise the graphics hardware, few are going to care about
>>>making life easier for Linux.
>>
> [...]
>>3. Get some shiny certification/label going that can be put on
>>fully conforming products as a sticker. Something like the old
>>"EPA pollution preventer" logo, but with a more appealing design.
>>Perhaps a "InstantOn/PowerSave" sticker, you get the idea.
> 
> Like "This machine actually works" sticker? :-)

Yes.

>>4. Include a mandantory description of video bringup after resume
> 
> That sounds overcomplicated. Simply add this to the specs:

You have to start to think like a vendor with a long legacy. Then my
spec draft will make more sense. Basically, you can't tell a vendor
that his hardware is broken or he will ignore your efforts from that
point on. "It's a question of honour." If, on the other hand, a
vendor can claim his products are conforming to the spec by issuing
a software update for broken hardware, it is much more likely that
the spec gets accepted.

> "BIOS must POST video during S3 wakeup. Video must be working
> and in 80x25 text mode when it jumps to OS. VESA BIOS calls must be
> available to the OS."

That would make some products non-conformant which are working
perfectly today. If the video state is preserved over S3, it doesn't
make sense to declare that behaviour non-conformant.

> BIOS must do that during normal boot; this should be very little
> additional work.

Not necessarily. Some BIOSes stay in graphics mode during the whole
bootup (at least it seems so) and would have to include additional
code to enter 80x25 text mode.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
