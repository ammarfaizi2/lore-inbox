Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132680AbRDIDZ5>; Sun, 8 Apr 2001 23:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132681AbRDIDZs>; Sun, 8 Apr 2001 23:25:48 -0400
Received: from infortrend.com.tw ([203.67.221.1]:29452 "EHLO infortrend.com.tw")
	by vger.kernel.org with ESMTP id <S132680AbRDIDZf>;
	Sun, 8 Apr 2001 23:25:35 -0400
Reply-To: <warren@infortrend.com.tw>
From: "warren" <warren@infortrend.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: race condition on looking up inodes
Date: Mon, 9 Apr 2001 11:26:51 +0800
Message-ID: <000201c0c0a4$eb5c7b10$321ea8c0@saturn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
    I had post a simillar message before.
    Thanks for the replay from Albert D. Cahalan. But i found some results
confusing me.
    For example,  process 1 and process 2 run concurrently and execute the
following system calls.

    rename("/usr/hybrid/cfg/data","/usr/mytemp/data1"); /*for process 1*/

   ----------------------------------------------------------------

  rename("/usr/mytemp/data1","/usr/test");/* for process 2*/

  ----------------------------------------------------------------
  It is possible that context switch happens when process 1 is look ing up
the inode for "/usr/mytemp/data1"  or the inode for "/usr/hybrid/cfg/data".

 It will result in diffrent behaviour for process 2 and confuses the
application.
  If so,how does Linux solve?

  Thanks.


    Warren

