Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129163AbQKMISr>; Mon, 13 Nov 2000 03:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbQKMISi>; Mon, 13 Nov 2000 03:18:38 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:39951 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129112AbQKMISY>; Mon, 13 Nov 2000 03:18:24 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B27092@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: "'LNML'" <linux-net@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: RE: catch 22 - porting net driver from 2.2 to 2.4
Date: Mon, 13 Nov 2000 00:18:06 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where can I find info about that ?
My first idea was to fire a timer and let the callback routine do the work,
but I worry about synchronization and about passing the list of items for it
to handle.
What is the accepted way of starting a kernel thread and how do I handle
parameters and sync. ?


	Thanks,
	Shmulik.

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
Sent: Thursday, November 09, 2000 7:37 PM
To: Hen, Shmulik
Cc: 'LNML'; 'LKML'; netdev@oss.sgi.com
Subject: Re: catch 22 - porting net driver from 2.2 to 2.4


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
To unsubscribe from this list: send the line "unsubscribe linux-net" in
the body of a message to majordomo@vger.kernel.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
