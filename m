Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVCPI4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVCPI4Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 03:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVCPI4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 03:56:23 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:7648 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261904AbVCPI4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 03:56:18 -0500
Message-ID: <4237F4B0.2040509@dgreaves.com>
Date: Wed, 16 Mar 2005 08:56:16 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: Matt Mackall <mpm@selenic.com>, Pavel Machek <pavel@ucw.cz>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.2
References: <4231E75A.4090203@tmr.com><4231E75A.4090203@tmr.com> <20050311190825.GW3120@waste.org> <423747BC.2080703@tmr.com>
In-Reply-To: <423747BC.2080703@tmr.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Matt Mackall wrote:
>
>> In your world, do you want to do:
>>
>> cp -rl linux-2.6.11 linux-2.6.11.5
>> cd linux-2.6.11.5
>> bzcat ../Patches/patch-2.6.11.1.bz2 | patch -p1
>> bzcat ../Patches/patch-2.6.11.2.bz2 | patch -p1
>> bzcat ../Patches/patch-2.6.11.3.bz2 | patch -p1
>> bzcat ../Patches/patch-2.6.11.4.bz2 | patch -p1
>> bzcat ../Patches/patch-2.6.11.5.bz2 | patch -p1
>>
>> I suspect you might find that tedious, especially if only the last one
>> addressed a bug that affected you.
>
>
> Being lazy, I would do
> bzcat ../Patches/patch-2.6.11.*.bz | patch -p1
> (or similar). But as I posted long ago when this discussion started it 
> is desirable to have both.
>
being super lazy I'd type:
scripts/patch-kernel . ../Patches

nb it's currently broke as mentioned in another thread:
Re: [BUG] Re: [PATCH] scripts/patch-kernel: use EXTRAVERSION
being fixed though. It will (I assume!) embody whatever rules are needed 
to revoke patches to go from 2.6.11.5 to 2.6.12 (and since I think the 
new version has d/l facilities, that should assist in the case of a base 
kernel d/l of 2.6.11.3 for which no local patches exist to revert prior 
to patching to 2.6.12)

David


