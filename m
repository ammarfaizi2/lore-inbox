Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129575AbQKIRhx>; Thu, 9 Nov 2000 12:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129657AbQKIRhn>; Thu, 9 Nov 2000 12:37:43 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:26892 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129575AbQKIRh3>;
	Thu, 9 Nov 2000 12:37:29 -0500
Message-ID: <3A0AE0D1.FB12725A@mandrakesoft.com>
Date: Thu, 09 Nov 2000 12:37:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Hen, Shmulik" <shmulik.hen@intel.com>
CC: "'LNML'" <linux-net@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: catch 22 - porting net driver from 2.2 to 2.4
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B2708C@hasmsx52.iil.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_ioctl is inside rtnl_lock...

Remember if you need to alter the rules, you can always queue work in
the current context, and have a kernel thread handle the work.  The nice
thing about a kernel thread is that you start with a [almost] clean
state, when it comes to locks.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
