Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319330AbSHQDNs>; Fri, 16 Aug 2002 23:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319331AbSHQDNs>; Fri, 16 Aug 2002 23:13:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32017 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319330AbSHQDNr>;
	Fri, 16 Aug 2002 23:13:47 -0400
Message-ID: <3D5DC054.4010403@mandrakesoft.com>
Date: Fri, 16 Aug 2002 23:17:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: harish.vasudeva@amd.com
CC: linux-kernel@vger.kernel.org
Subject: Re: need help with pci_module_init
References: <CB35231B9D59D311B18600508B0EDF2F04F285D0@caexmta9.amd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

harish.vasudeva@amd.com wrote:> hi folks
> 
>  pci_module_init() works fine only the first time i load my driver.
 >  subsequent loads will fail with this call returning -19!! any clues?


It works in the various PCI drivers in drivers/net/* ...   I debug 
modules all the time by repeatedly loading and unloading them.

Make sure to check that you are using SET_MODULE_OWNER immediately 
following your alloc_etherdev() call.  It sounds like you might have 
messed-up module counts.  Also "cat /proc/modules" to check the module 
reference count correctness.

	Jeff




