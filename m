Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVBWJru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVBWJru (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 04:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVBWJru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 04:47:50 -0500
Received: from farside.demon.co.uk ([62.49.25.247]:60655 "EHLO
	mail.farside.org.uk") by vger.kernel.org with ESMTP id S261441AbVBWJrp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 04:47:45 -0500
From: Malcolm Rowe <malcolm-linux@farside.org.uk>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Symlink /sys/class/block to /sys/block (fwd)
Date: Wed, 23 Feb 2005 09:47:44 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <courier.421C5140.00003F05@mail.farside.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes: 

>> Following the discussion in [1], the attached patch creates /sys/class/block
>> as a symlink to /sys/block. The patch applies to 2.6.11-rc4-bk7.   
>> 
>> Please cc: me on any replies - I'm not subscribed to the mailing list. 
> Hm, your patch is linewrapped, and can't be applied :(

Bah, and I did send it to myself first, but I guess my mailer un-flowed it 
for me :-(.  I'll try to find a better mailer. 

> But more importantly:
>> static void disk_release(struct kobject * kobj)
> 
> Did you try to remove a disk (like a usb device) and see what happens
> here?  Hint, this isn't the proper place to remove the symlink...

Er, yeah. Oops. 

*Is* there a sensible place to remove the symlink from, though?  Nobody 
seems to call subsystem_unregister(&block_subsys), which is the place I'd 
expect to add a call to, and I can't see anything that's otherwise 
obvious... 

Regards,
Malcolm 

[resent using the right address for linux-kernel. Sorry for the duplicate, 
Greg]
