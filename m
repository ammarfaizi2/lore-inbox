Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263524AbTKQOkG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 09:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTKQOkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 09:40:06 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:26826 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263524AbTKQOkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 09:40:02 -0500
Message-ID: <3FB8DDB9.8080709@nortelnetworks.com>
Date: Mon, 17 Nov 2003 09:39:53 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted?
References: <200311162009.52813.arvidjaar@mail.ru> <3FB7D52A.7020402@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Andrey Borzenkov wrote:
> 
>> Apparently not:
>>
>> {pts/1}% head -2 /proc/mounts
>> rootfs / rootfs rw 0 0
>> /dev/root / reiserfs rw 0 0
>>
>> at least it is still mounted. Is there any way to free it?

> rootfs is always present.  It's the root, as the name implies :)

He's got two root filesystems, one on top of the other.  It should be 
possible to pivot root rather than mount the second one, thus freeing up 
the memory from the initramfs.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

