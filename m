Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265759AbSKKQgK>; Mon, 11 Nov 2002 11:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbSKKQgK>; Mon, 11 Nov 2002 11:36:10 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:57561 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S265759AbSKKQgJ>; Mon, 11 Nov 2002 11:36:09 -0500
Message-ID: <3DCFDE0A.1030506@nortelnetworks.com>
Date: Mon, 11 Nov 2002 11:42:50 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: strange behaviour with statfs() call, looking for advice
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I seem to be getting some strange interactions between kernel space and 
userspace with the statfs() call.

On an nfs-mounted but unaccessable system, the statfs() call is 
returning a block count of 4294967295.  Since the kernel statfs struct 
has this field defined as a long and this is a 32-bit system, this is 
somewhat confusing.

It turns out that the userspace headers define the "blocks" field as a 
__fsblkcnt_t, which is then defined as __u_long.

What do I do?  Do I cast it to a long since I know that this is what the 
kernel is using?

The system in question is a yellowdog system, but the same problem is 
present on a recent mandrake box as well.  Is this a redhat issue?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

