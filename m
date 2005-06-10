Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVFJKaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVFJKaN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 06:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVFJK2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 06:28:38 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:19840 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262549AbVFJK2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 06:28:06 -0400
Message-ID: <42A96C05.4090301@jp.fujitsu.com>
Date: Fri, 10 Jun 2005 19:31:33 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Wilcox <matthew@wil.cx>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 00/10] IOCHK interface for I/O error handling/detecting
References: <42A8386F.2060100@jp.fujitsu.com>	 <20050609171332.GC24611@parcelfarce.linux.theplanet.co.uk> <1118355999.6850.177.camel@gaston>
In-Reply-To: <1118355999.6850.177.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Benjamin Herrenschmidt wrote:
>>>- Additionally adds special token - abstract "iocookie" structure
>>>  to control/identifies/manage I/Os, by passing it to OS.
>>>  Actual type of "iocookie" could be arch-specific. Device drivers
>>>  could use the iocookie structure without knowing its detail.
>>
>>I'm not sure we need this.  Surely it can be deduced from the pci_dev or
>>struct device?
> 
> Might be useful to know more though, wether it was PIO or MMIO or other
> things. Also, I'd like to carry around the possible error details as can
> be returned by the firmware in some platforms.
> 
> In fact, Is there any reason this is not ioerr_cookie instead of
> iocookie ? :)

To be honest, No :)
Or is there any reason to limit use of this cookie only for errors?

Thanks,
H.Seto

