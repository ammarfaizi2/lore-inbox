Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVACVfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVACVfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVACVfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:35:33 -0500
Received: from terminus.zytor.com ([209.128.68.124]:14749 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261298AbVACVf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:35:28 -0500
Message-ID: <41D9BA8B.2000108@zytor.com>
Date: Mon, 03 Jan 2005 13:35:07 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicholas Miell <nmiell@comcast.net>
CC: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
References: <41D9B1C4.5050507@zytor.com> <1104787447.3604.9.camel@localhost.localdomain>
In-Reply-To: <1104787447.3604.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell wrote:
> On Mon, 2005-01-03 at 12:57 -0800, H. Peter Anvin wrote:
> 
>>This patch adds a set of ioctls to get and set the FAT filesystem native 
>>attribute bits, including the unused bits (6 and 7.)
>>
> 
> 
> Instead of adding another ioctl, wouldn't an xattr be more appropriate?
> For instance, system.fatattrs containing a text representation of the
> attribute bits.
> 

This really worries me, because it's not clear to me that Microsoft 
isn't going to add NTFS-style xattrs to FAT in the future.  There is a 
very specific reason why they might want to do that: since they want to 
keep NTFS secret and proprietary, FAT is the published interchange 
format that other devices can use to exchange data with MS operating 
systems.  If we then have overloaded the xattr mechanism, that would be 
very ugly.

	-hpa
