Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932721AbWCJLGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbWCJLGg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 06:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbWCJLGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 06:06:36 -0500
Received: from dougal.buttersideup.com ([195.200.137.69]:9425 "EHLO
	smtp.buttersideup.com") by vger.kernel.org with ESMTP
	id S1752178AbWCJLGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 06:06:35 -0500
Message-ID: <44115DA4.604@buttersideup.com>
Date: Fri, 10 Mar 2006 11:06:12 +0000
From: Tim Small <tim@buttersideup.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dave Peterson <dsp@llnl.gov>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: [PATCH] EDAC: core EDAC support code
References: <200601190414.k0J4EZCV021775@hera.kernel.org>	 <200603091551.25097.dsp@llnl.gov> <20060310000227.GA30236@kroah.com>	 <200603091746.51686.dsp@llnl.gov> <1141976218.2876.2.camel@laptopd505.fenrus.org>
In-Reply-To: <1141976218.2876.2.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> It depends on how many PCI devices in your machine you wish to
>
>>blacklist or whitelist.  The motivation for this feature is that
>>certain known badly-designed devices report an endless stream of
>>spurious PCI bus parity errors.  We want to skip such devices when
>>checking for PCI bus parity errors.
>>    
>>
>
>ok so this is actually a per pci device property!
>I would suggest moving this property to the pci device itself, not doing
>it inside an edac directory.
>  
>
Yes, this seems more sensible to me.  For one thing, I suspect that just 
keying on vendor:device is probably too blunt for this and that 
blacklisting a particular PCI device revision is a likely requirement, 
as well as subsystem vendor/subsystem device.

Tim.

