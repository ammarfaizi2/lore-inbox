Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVFAWjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVFAWjz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVFAWh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:37:26 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:38800 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261345AbVFAWgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:36:07 -0400
Message-ID: <429E37BA.7090502@keyaccess.nl>
Date: Thu, 02 Jun 2005 00:33:30 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Pavel Machek <pavel@ucw.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl> <20050601081810.GA23114@elf.ucw.cz> <429DFD90.10802@keyaccess.nl> <200506011240.09540.david-b@pacbell.net> <429E3338.9000401@keyaccess.nl>
In-Reply-To: <429E3338.9000401@keyaccess.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:

> David Brownell wrote:

>> The experiment: verify that only the RUN bit is set on your machine
>> too. If "Periodic" and/or "Async" bits are set, then the controller
>> is _supposed_ to be issuing DMA transfers over PCI, so less bandwidth
>> will be available. Otherwise, not.

[ snip ]

> and one after switching on the USB2 HDD, when the hdparm result for hda 
> has dropped to 42 MB/s:
> 
> ===
> bus pci, device 0000:00:09.2 (driver 10 Dec 2004)
> EHCI 1.00, hcd state 1
> structural params 0x00002204
> capability params 0x00006872
> status a008 Async Recl FLR

Only see that "Async" now while rereading. Did you mean that one? If so, 
I'm right now catting the registers file and that "Async" is toggling on 
and off continuously. 4 cats in a row:

status 0008 FLR
status 8008 Async FLR
status a008 Async Recl FLR
status 0008 FLR

Rene.
