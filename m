Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbVIBWSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbVIBWSO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbVIBWSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:18:14 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:1804 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S1161081AbVIBWSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:18:13 -0400
Message-ID: <4318CF95.5040801@rulez.cz>
Date: Sat, 03 Sep 2005 00:17:57 +0200
From: iSteve <isteve@rulez.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: SysFS, module names and .name
References: <43176488.2080608@rulez.cz> <20050902155338.GA13648@kroah.com>
In-Reply-To: <20050902155338.GA13648@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I am rather interested -- could you please provide details about 
this method?

Thanks in advance.

  - iSteve

Greg KH wrote:
> On Thu, Sep 01, 2005 at 10:28:56PM +0200, iSteve wrote:
> 
>>Greetings,
>>in sysfs, /sys/bus/*/drivers lists the driver names, with their exported 
>>.name (eg. '.name = "EMU10K1_Audigy"' in the module code, from now on 
>>'driver name'). In /sys/modules, the kernel modules are listed with 
>>their module name, eg. snd_emu10k1. However, it seems to me that in 
>>sysfs, there is no way in particular to tell, which module has which 
>>.name. That is, that snd_emu10k1 is EMU10K1_Audigy and vice versa.
>>
>>I wonder whether it wouldn't be possible to add a symlink to the 
>>particular module from the driver, and/or from the module to the driver, 
>>so the list of devices handled by the module and the module name would 
>>be accessible. This way, I would know which driver name corresponds to 
>>which module name and vice versa.
> 
> 
> It's already automatically created for some bus drivers (like USB).  I
> had a simple patch to enable this for PCI, but haven't gotten around to
> changing every single pci driver to enable it.  If you want to do so,
> it isn't tough at all.
> 
> thanks,
> 
> greg k-h
