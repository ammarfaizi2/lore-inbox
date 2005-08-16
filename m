Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbVHPPoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbVHPPoD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 11:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbVHPPoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 11:44:01 -0400
Received: from pop.gmx.de ([213.165.64.20]:25058 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030192AbVHPPoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 11:44:00 -0400
X-Authenticated: #26200865
Message-ID: <430209D2.1000307@gmx.net>
Date: Tue, 16 Aug 2005 17:44:18 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: acpi-devel <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] PCI quirks not handled and config space differences
 on resume from S3
References: <Pine.LNX.4.44L0.0508161131240.18233-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0508161131240.18233-100000@iolanthe.rowland.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern schrieb:
> On Tue, 16 Aug 2005, Carl-Daniel Hailfinger wrote:
> 
> 
>>Hi,
>>[...]
>>Besides that, a number of drivers do not restore the pci config
>>space of their associated devices properly on resume from S3.
>>
>>These drivers (and associated devices) are:
>>- uhci_hcd (USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller)
>>[...]
>>Diff between "lspci -vvvxxx" before and after resume for all
>>problematic devices on my machine is attached.
>>
>>Are there any patches I can try?
> 
> 
> The uhci-hcd driver _does_ restore the config space for its devices 
> properly.
> 
>> [lspci dump]
> 
> 
> Just because the before and after values are different doesn't mean 
> anything is wrong.  Those particular bits are set by the hardware in 
> response to various events.  They are used only by the BIOS, to provide 
> USB keyboard and mouse services.  They don't affect the device's function 
> or the Linux driver at all.

Thanks for the information and sorry for bothering you.

> Alan Stern

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
