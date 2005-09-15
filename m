Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVIOOBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVIOOBF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 10:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVIOOBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 10:01:05 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:43445 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S964817AbVIOOBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 10:01:04 -0400
Message-ID: <43297E1A.7040408@sm.sony.co.jp>
Date: Thu, 15 Sep 2005 22:58:50 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][FAT] miss-sync issues on sync mount (miss-sync on
 utime)
References: <43288A84.2090107@sm.sony.co.jp> <87oe6uwjy7.fsf@devron.myhome.or.jp>
In-Reply-To: <87oe6uwjy7.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



OGAWA Hirofumi wrote:
> "Machida, Hiroyuki" <machida@sm.sony.co.jp> writes:
> 
> 
>>+	if ( (!error) && IS_SYNC(inode)) {
>>+		error = write_inode_now(inode, 1);
>>+	}
> 
> 
> We don't need to sync the data pages at all here. And I think it is
> not right place for doing this.  If we need this, since we need to see
> O_SYNC for fchxxx() VFS would be right place to do it.

I see, I'll look into those.

> But, personally, I'd like to kill the "-o sync" stuff for these
> independent meta data rather. Then...

-- 
Hiroyuki Machida		machida@sm.sony.co.jp		
SSW Dept. HENC, Sony Corp.
