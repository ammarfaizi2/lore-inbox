Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275289AbTHMRu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 13:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275290AbTHMRu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 13:50:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63408 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275289AbTHMRuS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 13:50:18 -0400
Message-ID: <3F3A7A4D.5070603@pobox.com>
Date: Wed, 13 Aug 2003 13:50:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <willy@debian.org>, davem@redhat.com,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk> <20030812053826.GA1488@kroah.com> <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk> <20030812180158.GA1416@kroah.com> <20030812235324.GA12953@redhat.com> <3F3A5EAA.5070000@techsource.com>
In-Reply-To: <3F3A5EAA.5070000@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> Dave Jones wrote:
>>     {
>>         .vendor        = PCI_VENDOR_ID_BROADCOM,
>>         .devices    = {
>>             PCI_DEVICE_ID_TIGON3_5700,
>>             PCI_DEVICE_ID_TIGON3_5701,
>>             PCI_DEVICE_ID_TIGON3_5702,
>>             PCI_DEVICE_ID_TIGON3_5703,
>>             PCI_DEVICE_ID_TIGON3_5704,
>>             PCI_DEVICE_ID_TIGON3_5702FE,
>>             PCI_DEVICE_ID_TIGON3_5702X,
>>             PCI_DEVICE_ID_TIGON3_5703X,
>>             PCI_DEVICE_ID_TIGON3_5704S,
>>             PCI_DEVICE_ID_TIGON3_5702A3,
>>             PCI_DEVICE_ID_TIGON3_5703A3,
>>         },
>>         .subvendor    = PCI_ANY_ID,
>>         .subdevice    = PCI_ANY_ID

> struct devicelist BROADCOM_devs[] {
>     PCI_DEVICE_ID_TIGON3_5700,
>     PCI_DEVICE_ID_TIGON3_5701,
>     PCI_DEVICE_ID_TIGON3_5702,
>     PCI_DEVICE_ID_TIGON3_5703,
>     PCI_DEVICE_ID_TIGON3_5704,
>     PCI_DEVICE_ID_TIGON3_5702FE,
>     PCI_DEVICE_ID_TIGON3_5702X,
>     PCI_DEVICE_ID_TIGON3_5703X,
>     PCI_DEVICE_ID_TIGON3_5704S,
>     PCI_DEVICE_ID_TIGON3_5702A3,
>     PCI_DEVICE_ID_TIGON3_5703A3,
>     LIST_TERMINATOR};


This is proving my point ;-)

You guys are stretching the bounds of C with syntactic sugar, to make it 
do something it doesn't do well:  store data.

Better to store the data outside the C code, where you don't have to do 
all this C mangling, and then use an automated tool to generate the C 
code representing pci_device_id tables.

	Jeff



