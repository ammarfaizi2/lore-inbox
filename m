Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTLWQKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTLWQKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:10:30 -0500
Received: from bay8-dav35.bay8.hotmail.com ([64.4.26.92]:58124 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261875AbTLWQKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:10:10 -0500
X-Originating-IP: [194.236.130.199]
X-Originating-Email: [nikomail@hotmail.com]
From: "Nicklas Bondesson" <nikomail@hotmail.com>
To: "'Walt H'" <waltabbyh@comcast.net>
Cc: <linux-kernel@vger.kernel.org>, "'Andre Hedrick'" <andre@linux-ide.org>
Subject: RE: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Tue, 23 Dec 2003 17:10:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <3FE859C6.3070804@comcast.net>
Thread-Index: AcPJZoh5zNKq2LEIRf+B6JHwQ+90ZwACIMHg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY8-DAV35gCkxRhjns000118f9@hotmail.com>
X-OriginalArrivalTime: 23 Dec 2003 16:10:08.0673 (UTC) FILETIME=[3C4CE110:01C3C96F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the info, but yet I had to go with your patch to get it up and
running. I think the patch should be included in the official kernel
release.

Who should we send this to?

/Nicke

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Walt H
Sent: den 23 december 2003 16:06
To: Nicklas Bondesson
Cc: linux-kernel@vger.kernel.org; 'Andre Hedrick'
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
(PDC20271)

Nicklas Bondesson wrote:
> The fix for me was to disable all "Power Management" in the kernel and 
> re-compile it. Works like a charm now :)
> 
> Hope this can help anyone else with the same problem as me. But again, 
> I think someone should take a look at it cos I think this is a bug for
sure.
> 
> /Nicke
> 

Nicke,

Glad to hear you got it working. Check out http://acpi.sourceforge.net for
acpi related information. If you can get it working with acpi=off and it
doesn't when you don't pass that flag, I'd say that there's at least
something fishy happening with acpi on your machine.

As for getting it running on 2.6 with dm, the only way I know of is to
create a custom initrd file by hand. You have to compile the lvm-dm tools
statically and create mappings first. Then in the linuxrc script, you need
run dmsetup and point it at the config files to create the devices. Until
this is handled better it's not really recommended. Good luck,

-Walt


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
