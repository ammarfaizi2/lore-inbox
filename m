Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130967AbRCFPMj>; Tue, 6 Mar 2001 10:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130966AbRCFPM3>; Tue, 6 Mar 2001 10:12:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40457 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130967AbRCFPMW>; Tue, 6 Mar 2001 10:12:22 -0500
Subject: Re: [PATCH] Lanstreamer in kernel support
To: sullivam@us.ibm.com (Mike Sullivan)
Date: Tue, 6 Mar 2001 15:15:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF850AEE47.7AEEA8C4-ON85256A07.004F9AFE@raleigh.ibm.com> from "Mike Sullivan" at Mar 06, 2001 08:35:02 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14aJBI-0000q2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is a small patch that allows the lanstreamer to be built as an in
> kernel device. This code
> is already in the 2.2.x tree but was dropped somewhere along the way.

You might want to consider getting a working mail client ;)

>                                                                            
>                                            && olympic_probe(dev)           
>                                       +#endif                              
>                                       +#ifdef CONFIG_IBMLS                 
>                                       +    && streamer_probe(dev)          
>                                        #endif                              

This seems wrong

>                                                                            
>                                       +static struct pci_device_id         
>                                       streamer_pci_tbl[] __initdata = {    
>                                       +    { PCI_VENDOR_ID_IBM,            
>                                       PCI_DEVICE_ID_IBM_TR, PCI_ANY_ID,    
>                                       PCI_ANY_ID,},                        
>                                       +    {}   /* terminating entry */    
>                                       +};                                  
>                                       +MODULE_DEVICE_TABLE(pci,streamer_pc 
>                                       i_tbl);                              
>

This is beliveable but too mangled to use
