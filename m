Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUCWCEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbUCWCEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:04:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21411 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261891AbUCWCE3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:04:29 -0500
Message-ID: <405F9B1F.4000403@pobox.com>
Date: Mon, 22 Mar 2004 21:04:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Joe Blow <joeblow341@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Promise 20378 + 2.6.0-test10 + libata patch 1
References: <BAY7-F848IdgO3RQppH0000114d@hotmail.com> <3FCC014A.7050109@pobox.com> <20031202052015.GA28551@codepoet.org>
In-Reply-To: <20031202052015.GA28551@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Mon Dec 01, 2003 at 10:04:42PM -0500, Jeff Garzik wrote:
> 
>>Joe Blow wrote:
>>
>>>>From: Jeff Garzik <jgarzik@pobox.com>
>>>>
>>>>Nope, libata Promise driver only supports Serial ATA.
>>>
>>>
>>>Bummer.  Will it ever support PATA?
>>
>>No plans.
> 
> 
> What exactly is needed to get got SATA and PATA support
> comparable to the driver provided by promise?  Would it be
> possible to adapt the existing promise PATA IDE driver to drive
> the PATA port, while the libata Promise driver handles the SATA
> ports.  Or would a new driver be needed?
> 
> How would the two drivers share the same PCI device?

It looks like libata pretty much needs to do PATA, in this case and a 
couple others.  Promise sent me a couple 2037x test cards with a PATA 
port on them, so just now need the time... :)

Getting PATA disks working should be very, very easy.  Getting ATAPI 
devices working requires some libata core hacking, though the ATAPI code 
is mostly there already.

	Jeff




