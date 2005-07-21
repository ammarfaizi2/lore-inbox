Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVGUWOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVGUWOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 18:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVGUWOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 18:14:48 -0400
Received: from ptr-64-201-187-87.ptr.terago.ca ([64.201.187.87]:660 "HELO
	mars.net-itech.com") by vger.kernel.org with SMTP id S261900AbVGUWOr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 18:14:47 -0400
Message-ID: <42E01E56.4080301@nit.ca>
Date: Thu, 21 Jul 2005 18:14:46 -0400
From: Lukasz Kosewski <lkosewsk@nit.ca>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: jgarzik@pobox.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Add disk hotswap support to libata
References: <42E01024.9030600@nit.ca> <42E01A68.6000002@tls.msk.ru>
In-Reply-To: <42E01A68.6000002@tls.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> echo -n 1 > /sys/.../hostA/targetA:B:C/A:B:C:D/delete
> still works.  I think.
> And (again, I think) this same problem exists with 2.6.11 as well.
> At least, I wasn't able to remove-single-device even once (I discovered
> this mechanism only recently, haven't tried it with other kernels).

You're both correct and incorrect based on my testing; in 2.6.11.12, I 
have no problems.

However, in 2.6.13-rc1-mm1, you're right that echoing 1 into the delete 
node does remove the device.

It seems that there is some issue with the 'scsi_device_lookup' function 
then?

I'd have to debug further.

Luke Kosewski
Human Cannonball
Net Integration Technologies
