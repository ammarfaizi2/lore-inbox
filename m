Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVCFSk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVCFSk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 13:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVCFSk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 13:40:26 -0500
Received: from smartmx-01.inode.at ([213.229.60.33]:23742 "EHLO
	smartmx-01.inode.at") by vger.kernel.org with ESMTP id S261462AbVCFSkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 13:40:21 -0500
Message-ID: <422B4E97.4090303@inode.info>
Date: Sun, 06 Mar 2005 19:40:23 +0100
From: Richard Fuchs <richard.fuchs@inode.info>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Scott Feldman <sfeldma@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: slab corruption in skb allocs
References: <42283093.7040405@inode.info> <20050304035309.1da7774e.akpm@osdl.org> <42285354.5090900@inode.info> <93832c6db45c33f7b2f195aae0d469dc@pobox.com> <422A041E.40105@inode.info> <0a8f9833de8ba3f767f3b3211bbb693a@pobox.com>
In-Reply-To: <0a8f9833de8ba3f767f3b3211bbb693a@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Feldman wrote:
> On Mar 5, 2005, at 11:10 AM, Richard Fuchs wrote:

>> looks like you are right, enabling NAPI in 2.6.7 does trigger this.
>>
>> what exactly is this?

> A bug in the driver.  I have a hunch: please try this patch with 2.6.9 
> or higher:
> 
> http://marc.theaimsgroup.com/?l=linux-netdev&m=110726809431611&w=2

bingo, that fixes it. too bad neither this patch nor the removal of the 
NAPI config option made it into 2.6.11...

>>   also, does this affect the e1000 driver in any way?

> No.  e1000 is a totally different driver/device with very similar name.

too bad, i was hoping for an explanation for some unexplainable crashes 
i've been experiencing... ;)

cheers
richard
