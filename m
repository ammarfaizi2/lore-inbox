Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUL1EBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUL1EBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 23:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbUL1EBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 23:01:37 -0500
Received: from fmr20.intel.com ([134.134.136.19]:16803 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262060AbUL1EBd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 23:01:33 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: the patch of restore-pci-config-space-on-resume break S1 onASUS2400 NE
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Tue, 28 Dec 2004 12:01:04 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8406A730C0@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: the patch of restore-pci-config-space-on-resume break S1 onASUS2400 NE
Thread-Index: AcTsIzDXacrPzOwoQSS/9LuVEbrFtAAbbNNw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>
Cc: "Arjan van de Ven" <arjanv@redhat.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>,
       "Fu, Michael" <michael.fu@intel.com>
X-OriginalArrivalTime: 28 Dec 2004 04:01:04.0929 (UTC) FILETIME=[DA408110:01C4EC91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the idea in post
http://sourceforge.net/mailarchive/message.php?msg_id=9091508
cure S1 resume hang for my ASUS2400NE.

I guess Len will accept it.

Does it imply IDE DMA  could be started too early in the original resume code?

Thanks,
Luming

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: 2004Äê12ÔÂ27ÈÕ 21:45
To: Yu, Luming
Cc: Arjan van de Ven; Pavel Machek; Brown, Len; Li, Shaohua; Pallipadi, Venkatesh; Linux Kernel Mailing List; acpi-devel@lists.sourceforge.net; Fu, Michael
Subject: RE: the patch of restore-pci-config-space-on-resume break S1 onASUS2400 NE

On Llu, 2004-12-27 at 10:14, Yu, Luming wrote:
>  Actually, the kernel (after removing restore-pci-config-space-on-resume patch) with option "ide=nodma" 
> can work with S1 suspend/resume without any hang so far.
>   So my suggestion for IDE driver is to disable DMA before entering S1, and enable
> DMA after resuming from S1 if DMA was enabled.  I need help from IDE guys to confirm it.

The IDE layer has no problem doing this, although it raises interesting
questions about why it would be neccessary. 

