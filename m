Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbTC0Jlp>; Thu, 27 Mar 2003 04:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261841AbTC0Jlo>; Thu, 27 Mar 2003 04:41:44 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:12213 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261839AbTC0Jlo>; Thu, 27 Mar 2003 04:41:44 -0500
Message-ID: <3E82293A.1020805@gmx.net>
Date: Wed, 26 Mar 2003 23:27:06 +0100
From: Thomas Heinz <thomasheinz@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NLMSG_ALIGNTO macro
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

include/linux/netlink.h says: #define NLMSG_ALIGNTO 4

I think NLMSG_ALIGNTO should be 8 because the data may be a
struct containing a 64 bit member which requires 64 bit
alignment. In this case NLMSG_DATA will not work properly if
NLMSG_LENGTH(0) % 8 != 0.

Currently this is a "theoretical" issue as
sizeof(struct nlmsghdr) == 16.

Do you agree that the definition of NLMSG_ALIGNTO should
be changed?


Regards,

Thomas

PS: Please CC to my private e-mail address as I'm currently
     not subscribed.

