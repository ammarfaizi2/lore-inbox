Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA3CfH>; Mon, 29 Jan 2001 21:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRA3Ce5>; Mon, 29 Jan 2001 21:34:57 -0500
Received: from mail4.bigmailbox.com ([209.132.220.35]:55047 "EHLO
	mail4.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S129101AbRA3Cel>; Mon, 29 Jan 2001 21:34:41 -0500
Date: Mon, 29 Jan 2001 18:34:26 -0800
Message-Id: <200101300234.SAA20191@mail4.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [198.147.65.9]
From: "Quim K Holland" <qkholland@my-deja.com>
To: neilb@cse.unsw.edu.au, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Desk check of raid5.c patch from mtew@cds.duke.edu?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been following the recent 2.4.1-pre series and am wondering why the following one-liner
(obviously correct) patch has not been applied.  Maybe the original request from Neil to Linus
did not get through?

<http://marc.theaimsgroup.com/?l=linux-raid&m=97936073620401&w=2>

--- drivers/md/raid5.c  2001/01/13 04:31:15     1.1
+++ drivers/md/raid5.c  2001/01/13 04:31:30
@@ -1071,7 +1071,7 @@
                bh->b_end_io(bh, 1);
        }
        while ((bh=return_fail)) {
-               return_ok = bh->b_reqnext;
+               return_fail = bh->b_reqnext;
                bh->b_reqnext = NULL;
                bh->b_end_io(bh, 0);
        }


------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
