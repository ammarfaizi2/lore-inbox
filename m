Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUCaByK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUCaByK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:54:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35730 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261582AbUCaByD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:54:03 -0500
Message-ID: <406A24AD.3020208@pobox.com>
Date: Tue, 30 Mar 2004 20:53:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Zdenek Tlusty <tlusty@vse.cz>, linux-kernel@vger.kernel.org
Subject: Re: via 6420 pata/sata controller
References: <200403301524.26360.tlusty@vse.cz> <200403301728.47494.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403301728.47494.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 30 of March 2004 15:24, Zdenek Tlusty wrote:
> 
>>hello,
>>
>>I have problem with via 6420 controller under linux (I have mandrake 9.1
>>with kernel 2.4.25 with libata patch version 16).
>>This controller has two sata and one pata channels. Sata channel works fine
>>with libata. My problem is with pata channel. I have pata hard disk on this
>>controller. Bios of the controller detected this disk but linux did not.
>>What is the current status of the driver for this controller?
>>Thank you for your time.
> 
> 
> There are some patches floating around adding support for VT6410
> (not VT6420) to generic IDE PCI driver.  This controller may also work
> with generic IDE PCI driver (PCI VendorID/ProductID needs to be added
> to drivers/ide/pci/generic.h and drivers/ide/pci/generic.c).

VT 6420 should be added to via82cxxx.c, since it does the necessary bus 
setup and such.  AFAICS it is programmed just like all the other VIA 
PATA controllers.


> BTW Does anybody has contacts in VIA?

Sure...  I'll check my VT 6420 cards as well.  It should just be another 
PCI id added to via82cxxx.c.

	Jeff



