Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVCHA4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVCHA4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVCHAwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:52:16 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:34523 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262010AbVCHAtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 19:49:18 -0500
Date: Mon, 07 Mar 2005 18:49:05 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [CHECKER] crash after fsync causing serious FS corruptions (ext2,
 2.6.11)
In-reply-to: <3FnYi-11J-1@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <422CF681.3010109@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3Fnc7-mf-11@gated-at.bofh.it> <3FnYi-11J-1@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> fsync on ext2 only really guarantees that the data has reached
> the disk, what the disk does it outside the realm of the fs.
> If the ide drive has write back caching enabled, the data just
> might only be in cache. If the power is removed right after fsync
> returns, the drive might not get a chance to actually commit the
> write to platter.

Is this really the behavior in the current kernel? If so this seems 
quite wrong to me - if the application did an fsync, I think the kernel 
should be sending cache flush commands to the drive before the call 
completes..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

