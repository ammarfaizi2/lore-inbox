Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTLDOy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 09:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTLDOy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 09:54:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32458 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262128AbTLDOyW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 09:54:22 -0500
Message-ID: <3FCF4A8B.6030701@pobox.com>
Date: Thu, 04 Dec 2003 09:54:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Cormack <justin@street-vision.com>
CC: Andre Tomt <lkml@tomt.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org>	<1070494030.15415.111.camel@slurv.pasop.tomt.net> 	<3FCE737C.1080105@pobox.com> <1070545088.11956.43.camel@lotte.street-vision.com>
In-Reply-To: <1070545088.11956.43.camel@lotte.street-vision.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Cormack wrote:
> On Wed, 2003-12-03 at 23:36, Jeff Garzik wrote:
> 
>>Andre Tomt wrote:
>>
>>>On Wed, 2003-12-03 at 21:44, Jeff Garzik wrote:
>>>
>>>
>>>>Intel ICH5
>>>>----------
>>>>Summary:  No TCQ.  Looks like a PATA controller, but with a few added,
>>>>non-standard SATA port controls.
>>
>>>One question - with "including hotplug", does that mean some set hotplug
>>>standard? Reason I'm asking is, we have a few servers from SuperMicro,
>>>with a ICH5R S-ATA controller that claims it's supporting hotplug, but
>>>hotplug is not in your ICH5-summary.
>>
>>Alas, there is no hotplug support in the ICH5 or ICH5-R SATA hardware.
>>
>>One could argue there is "coldplug" support in that hardware -- disable 
>>the entire interface, including any active devices, then re-enable and 
>>re-scan -- but it's a bit of a hack.  If there's enough demand, I could 
>>write some code for that.  It would involve something like
>>
>>	# /sbin/sata off
>>	{ plug in or remove a device }
>>	# /sbin/sata on
>>
>>You really, really, really don't want to actually unplug a SATA drive 
>>while it's active, on ICH5 hardware.
> 
> 
> How does it work on other hardware?


Just yank the cord :)

	Jeff



