Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbRAOHG1>; Mon, 15 Jan 2001 02:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130769AbRAOHGR>; Mon, 15 Jan 2001 02:06:17 -0500
Received: from ci424612-a.galatn1.tn.home.com ([24.2.18.178]:23880 "EHLO
	mail.transverse.net") by vger.kernel.org with ESMTP
	id <S130006AbRAOHGG>; Mon, 15 Jan 2001 02:06:06 -0500
Message-Id: <4.3.2.7.2.20010115003923.00bcc910@10.0.0.10>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 15 Jan 2001 01:06:02 -0600
To: linux-kernel@vger.kernel.org
From: JJ Jordan <jj@codebynight.com>
Subject: Question relating to the nopage handler and memory in general
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I'm in the middle of developing a pseudo device driver under 
2.2.18.  Processes that use it generally mmap() it, and in the mmap 
handler, it sets up a nopage handler.  Here's the question: After the 
nopage handler has been called and pages have been mapped to client 
processes' spaces, how can I "unmap" certain pages from processes that 
memory has been mapped to, say from the ioctl handler?  If not unmap, then 
at least create a condition where the nopage handler would have to be 
called again for particular pages..

Any help would be appreciated.

Thanks,
John Jordan

PS- I did look briefly through the list archives but couldn't find 
anything.. and this is my first post to the list; if I sound like an idiot, 
well.. it's to be expected.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
