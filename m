Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVCFRpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVCFRpP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 12:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVCFRpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 12:45:15 -0500
Received: from orb.pobox.com ([207.8.226.5]:47298 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261442AbVCFRpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 12:45:09 -0500
In-Reply-To: <422A041E.40105@inode.info>
References: <42283093.7040405@inode.info> <20050304035309.1da7774e.akpm@osdl.org> <42285354.5090900@inode.info> <93832c6db45c33f7b2f195aae0d469dc@pobox.com> <422A041E.40105@inode.info>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0a8f9833de8ba3f767f3b3211bbb693a@pobox.com>
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
From: Scott Feldman <sfeldma@pobox.com>
Subject: Re: slab corruption in skb allocs
Date: Sun, 6 Mar 2005 09:44:05 -0800
To: Richard Fuchs <richard.fuchs@inode.info>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 5, 2005, at 11:10 AM, Richard Fuchs wrote:

> Scott Feldman wrote:
>
>> Was NAPI turned on for e100 in 2.6.7?  If not, turn NAPI on in the 
>> 2.6.7 driver and see if you get the same result.  If you do, it's 
>> very likely the bug is in the e100 driver's NAPI implementation.
>
> looks like you are right, enabling NAPI in 2.6.7 does trigger this.
>
> what exactly is this?

A bug in the driver.  I have a hunch: please try this patch with 2.6.9 
or higher:

http://marc.theaimsgroup.com/?l=linux-netdev&m=110726809431611&w=2

> i didn't enable NAPI in any of the newer kernel versions i was trying, 
> so i'm somewhat confused. :)

NAPI is the only option for new kernels.  2.6.7 had both NAPI and 
non-NAPI.

>   also, does this affect the e1000 driver in any way?

No.  e1000 is a totally different driver/device with very similar name.

-scott


