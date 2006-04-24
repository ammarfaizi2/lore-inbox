Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWDXRaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWDXRaG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWDXRaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:30:06 -0400
Received: from mailgw4.ericsson.se ([193.180.251.62]:28330 "EHLO
	mailgw4.ericsson.se") by vger.kernel.org with ESMTP
	id S1751026AbWDXRaD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:30:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ANNOUNCE] Release Digsig 1.5: kernel module forrun-timeauthentication of binaries
Date: Mon, 24 Apr 2006 13:29:37 -0400
Message-ID: <6D19CA8D71C89C43A057926FE0D4ADAA29D363@ecamlmw720.eamcs.ericsson.se>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] Release Digsig 1.5: kernel module forrun-timeauthentication of binaries
Thread-Index: AcZnvwAeRmTfxdSXS2eUkWN/iRuBRAAApI5Q
From: "Makan Pourzandi \(QB/EMC\)" <makan.pourzandi@ericsson.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
       "Serue Hallyen" <serue@us.ibm.com>,
       "Axelle Apvrille" <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       <disec-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 24 Apr 2006 17:29:38.0768 (UTC) FILETIME=[A9DC5D00:01C667C4]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Arjan van de Ven [mailto:arjan@infradead.org] 
> Sent: April 24, 2006 12:48 PM
> To: Makan Pourzandi (QB/EMC)
> Cc: linux-kernel@vger.kernel.org; 
> linux-security-module@vger.kernel.org; Serue Hallyen; Axelle 
> Apvrille; disec-devel@lists.sourceforge.net
> Subject: RE: [ANNOUNCE] Release Digsig 1.5: kernel module 
> forrun-timeauthentication of binaries

> ok I have to admit that this answer worries me.
> 
> how can it be covered? How do you distinguish an elf loader 
> application (which just uses open + mmap after all) with... 
> say a grep-calling perl script?
> 
> As long as you allow apps to mmap (or even just read() a file 
> into memory).... they can start acting like an elf loader if 
> they chose to do so. And.. remember it's not the files WITH 
> signature you're protecting against (which you could check) 
> but the ones WITHOUT. And there are many of those; and you 

Ok, I believe that now I see your point. You're right, to simplify if
your application reads an ELF file and begins to interpret that, Digsig
does not cover that case.  For me what you mention here rather concerns
the bahavior of the application, which is not what we intend to
implement here. Digsig functionality is limited to checking the validity
of the signature of your binary when Linux loads it. And, IMO, it should
be used with other security mechanisms and not alone. I believe though
this simple functionality can do much to avoid executing viruses or
other malware on your system.   

Regards 
Makan 


> can't sign ALL files I think, not without going through 
> really great hoops anyway.
> 
> 
> 
> 
