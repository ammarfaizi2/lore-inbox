Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVK2BLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVK2BLW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVK2BLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:11:22 -0500
Received: from smtpout.mac.com ([17.250.248.85]:31946 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932310AbVK2BLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:11:22 -0500
In-Reply-To: <20051128204950.GC17740@kroah.com>
References: <Pine.LNX.4.50.0511231336261.16769-100000@monsoon.he.net> <20051128204950.GC17740@kroah.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <37362F2B-D74A-4A40-905B-B25264B6C4AB@mac.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Updates to sysfs_create_subdir()
Date: Mon, 28 Nov 2005 20:10:36 -0500
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 28, 2005, at 15:49, Greg KH wrote:
> On Wed, Nov 23, 2005 at 01:56:29PM -0800, Patrick Mochel wrote:
>> The patch below addresses this issue by parsing the subdirectory  
>> name and creating any parent directories delineated by a '/'.
>
> Generally I never liked parsing stuff like this in the kernel (proc  
> and devfs both do this).  That being said, I do see the need to  
> make subdirs like this easier.
>
> But what about cleanups?  If I create an attribute group "foo/baz/ 
> x/" and then remove it, will the subdirectories get cleaned up  
> too?  What about if I had created a group "foo/baz/y/" after the  
> "x" one?  Or just "foo/baz"?

If the kernel gets this, then udev needs to allow attributes with  
more generic paths too.  It would be nice if I could use this [Pulled  
from the sample udev output halfway down this page: http:// 
www.reactivated.net/writing_udev_rules.html#identify-sysfs].

BUS="scsi", SYSFS{../../../manufacturer}="Tekom Technologies, Inc",  
NAME="my_camera"

Frequently the attributes one wants to filter by are spread out  
through the tree, especially when they've been subdivided for clarity  
as people seem to want to do.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer


