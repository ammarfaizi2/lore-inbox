Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVFASul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVFASul (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFASts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:49:48 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:59863 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S261516AbVFASc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:32:59 -0400
Message-ID: <429DFEBF.8090908@keyaccess.nl>
Date: Wed, 01 Jun 2005 20:30:23 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl> <429DA0A9.6010808@rtr.ca>
In-Reply-To: <429DA0A9.6010808@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:

> Look at "cat /proc/interrupts" and see if the USB is sharing
> an IRQ line with ide0.  If so, then the best explanation I can
> see is that the USB driver must have a *really slow* interrupt
> handler up to the point where it determines that the interrupt
> is not for it.

No, that's not it. Both ide0 (14) and EHCI (3) are on private, unshared 
IRQs. rmmodding ehci_hcd as per Pavel's sugestion gets me back my speed. 
Exactly _why_ I've no idea though. I've just added you to the CC on that 
reply...

Rene.
