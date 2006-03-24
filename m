Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWCXTFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWCXTFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWCXTFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:05:37 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:2460 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S932606AbWCXTFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:05:36 -0500
Message-ID: <442442CB.4090603@cs.wisc.edu>
Date: Fri, 24 Mar 2006 13:04:43 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Dave C Boutcher <boutcher@cs.umn.edu>
CC: Jeff Garzik <jeff@garzik.org>, Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>, ian.pratt@cl.cam.ac.uk,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>	<4421D943.1090804@garzik.org>	<1143202673.18986.5.camel@localhost.localdomain>	<4423E853.1040707@garzik.org>	<4423F60B.6020805@garzik.org>	<1143207657.2882.65.camel@laptopd505.fenrus.org>	<4423F91F.4060007@garzik.org> <17444.4455.240044.724257@hound.rchland.ibm.com>
In-Reply-To: <17444.4455.240044.724257@hound.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave C Boutcher wrote:
> Jeff Garzik wrote:
>> Arjan van de Ven wrote:
>>> On Fri, 2006-03-24 at 08:37 -0500, Jeff Garzik wrote:
>>>> Jeff Garzik wrote:
>>>>> In fact, SCSI should make a few things easier, because the notion of 
>>>>> host+bus topology is already present, and notion of messaging is already 
>>>>> present, so you don't have to recreate that in a Xen block device 
>>>>> infrastructure.
>>>> Another benefit of SCSI:  when an IBM hypervisor in the Linux kernel 
>>>> switched to SCSI, that allowed them to replace several drivers (virt 
>>>> disk, virt cdrom, virt floppy?) with a single virt-SCSI driver.
>>> but there's a generic one for that: iSCSI
>>> so in theory you only need to provide a network driver then ;)
>> Talk about lots of overhead :)
>>
>> OTOH, I bet that T10 is acting at high speed, right this second, to form 
>> a committee, and multiple sub-committees, to standardize SCSI 
>> transported over XenBus.  SXP anyone?  :)
> 
> Actually SRP (which T10 has now stopped working on) fits the bill very
> nicely.
> 

Does the IBM vscsi code/SPEC follow the SRP SPEC or is it slightly 
modified? We also have a SRP initiator in kernel now too. It is just not 
in the drivers/scsi dir.
