Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285829AbSBOCKp>; Thu, 14 Feb 2002 21:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286188AbSBOCK0>; Thu, 14 Feb 2002 21:10:26 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:55181 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S285829AbSBOCKV>;
	Thu, 14 Feb 2002 21:10:21 -0500
Message-ID: <3C6C6E0C.6000309@candelatech.com>
Date: Thu, 14 Feb 2002 19:10:20 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: copy_from_user returns a positive value?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an IOCTL defined something like this:

	_IOWR (0xfe, (30<<3 + 0), __u8 [696])

I'm really passing in a structure of size 696 (does that matter)?

When I make the copy from user call:

       if ((ret = copy_from_user(&reqconf, arg, sizeof(reqconf)))) {
          printk("ERROR: copy_from_user returned: %i, sizeof(reqconf): %i\n",
                 ret, sizeof(reqconf));
          return ret;
       }

I see this printed out:

ERROR: copy_from_user returned: 696, sizeof(reqconf): 696


According to some docs I saw on the web, it should return 0, or the
number it has left to copy.  So, why does it have 696 bytes left
to copy??

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


