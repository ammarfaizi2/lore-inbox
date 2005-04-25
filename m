Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVDYMBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVDYMBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 08:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbVDYMBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 08:01:17 -0400
Received: from [213.170.72.194] ([213.170.72.194]:34445 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S262561AbVDYMBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 08:01:12 -0400
Message-ID: <426CDC03.3020902@oktetlabs.ru>
Date: Mon, 25 Apr 2005 16:01:07 +0400
From: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Mansi.Mahur@infineon.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Mounting File System .
References: <D99246B510C34944823191CB90759C8652804C@blrse201.ap.infineon.com>
In-Reply-To: <D99246B510C34944823191CB90759C8652804C@blrse201.ap.infineon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mansi.Mahur@infineon.com wrote:
> I simply mount jffs2 on to a mount point
> and test for jffs2 . But the behaviour is seen that if I give mount
> point as /tmp and not any other directory I get abnormal behaviour like:
Frankly, I hardly understand what do you mean :-)

> 1.following log seen
> [root@Linux tmp]$ waiting for chip to be ready timed out in word write
> Write error in obliterating obsoleted node at 0x0011c570: -5
This implies JFFS2 can not write to flash. This must a problem of 
underlying layers (your driver is buggy, your HW is broken, etc).

> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
This probably a bug in JFFS2 - it doesn't handle an error gracefully.

Please, do the following:

1. inform us about your kernel version;
2. explore http://www.linux-mtd.infradead.org carefully;
3. try the latest MTD snapshot;
4. post to the MTD mailing list - all the MTD people are there.

If the last snapshot doesn't help, then:

1. enable MTD debugging and JFFS2 debug level 1 in your .config;
2. post the JFFS2/MTD debugging output;
3. post the output of 'cat /proc/mtd;
4. use the last MTD snapshot.

Cheers,
Artem.

-- 
Best regards, Artem B. Bityuckiy
Oktet Labs (St. Petersburg), Software Engineer.
+78124286709 (office) +79112449030 (mobile)
E-mail: dedekind@oktetlabs.ru, web: http://www.oktetlabs.ru
