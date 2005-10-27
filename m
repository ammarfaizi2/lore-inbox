Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVJ0Qnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVJ0Qnu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 12:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVJ0Qnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 12:43:50 -0400
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:27388 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1751261AbVJ0Qnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 12:43:49 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Doug Thompson'" <norsk5@yahoo.com>, <sander@humilis.net>
Cc: <linux-kernel@vger.kernel.org>, <sander@humilis.net>,
       "'Avuton Olrich'" <avuton@gmail.com>, "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: EDAC (was: Re: 2.6.14-rc5-mm1)
Date: Thu, 27 Oct 2005 11:50:00 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcXaanx+W69MSzdLSfWXGoeG9UiptAAqvbBQ
In-Reply-To: <20051026202200.76915.qmail@web50108.mail.yahoo.com>
Message-ID: <EXCHG20039GQvnbEG1000000328@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 27 Oct 2005 16:39:05.0064 (UTC) FILETIME=[F1B09E80:01C5DB14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 



> depends on your requirements.
> 
> we have been living with systems with PCI devices for a 
> decade now. how many times have events occurred that had no 
> explaination and are simply dismissed? There were no detectors.
> 
> We assume many things, even today.  How many desktops with 
> gigs of memory have no ECC? I have learned my lesson while 
> refactoring bluesmoke/edac that ECC is very important.  ECC 
> always in my machines for now on, for me anyway.

The bigger question is how many machines have ecc but no one is 
watching it for errors of any sort, the answer for this question
is almost all.   On opteron's mcelog does a decent job of alerting
people to memory issues, but not even all Enterprise distributions
include mcelog, but on the Xeons there is almost nothing
warning any of ecc failures, unless someone checks the bios event
logs on the few machinces that work, and this is fairly difficult,
so almost no one does.


> 
> For PCI devices, if you want to "know" data is being 
> transmitted correctly, then there needs to be "detector" and 
> "reporter" and "handler" agents of this bad events to 
> properly notice, report and process them.

And there are other PCI cards/motherboards that have timing issues
also, I know because I have personally found and debugged a
couple of them, one was nasty enough that it corrupted data on every
5-10GB of reads, and it was *ALL* motherboards of this type with a
certain given card running at 133mhz.  With a different manufacturer's
similar card it crashed with a MTBF of about when one would expect corrupted
data.   

                    Roger

