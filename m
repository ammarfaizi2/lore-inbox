Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWGVQxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWGVQxi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWGVQxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:53:38 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:5355 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1750918AbWGVQxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:53:37 -0400
Date: Sat, 22 Jul 2006 17:53:35 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: remove pci domain local copy (02/07)
In-Reply-To: <44C25392.5000508@garzik.org>
Message-ID: <Pine.LNX.4.64.0607221751570.5320@skynet.skynet.ie>
References: <11535827134076-git-send-email-airlied@linux.ie>
 <11535827133352-git-send-email-airlied@linux.ie> <11535827131612-git-send-email-airlied@linux.ie>
 <44C25392.5000508@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I would presume that hose goes away too?

Well not yet as I used it below...
>
>> +static inline int drm_get_pci_domain(struct drm_device *dev)
>> +{
>> +#ifdef __alpha__
>> +	return dev->hose->bus->number;
>> +#else
>> +	return 0;
>> +#endif
>> +}
>
> Please use the always-present pci_domain_nr() rather than inventing a 
> DRM-specific function that does the same thing.

Ah well I didn't know that existed, I merely was just moving some code in 
the DRM into another function in the DRM, it didn't occur that someone 
might have a generic function and not put it into the DRM code.. I'll look 
into it thanks,

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

