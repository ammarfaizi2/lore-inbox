Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267846AbTBROID>; Tue, 18 Feb 2003 09:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267847AbTBROID>; Tue, 18 Feb 2003 09:08:03 -0500
Received: from blr.vsnl.net.in ([202.54.12.6]:51708 "HELO blr.vsnl.net.in")
	by vger.kernel.org with SMTP id <S267846AbTBROIA>;
	Tue, 18 Feb 2003 09:08:00 -0500
Content-Disposition: inline; filename=""
Content-Transfer-Encoding: binary
Content-Type: text/plain; name=""
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.135  (B2.11; Q2.03)
To: linux-kernel@vger.kernel.org
From: <gskiran@bgl.vsnl.net.in>
Subject: Linux Kernel Message Queue Implementation
Date: Tue, Feb 18, 2003 at 19:47:52 IST (GMT+0530)
Message-Id: <20030218141257.1475574B6@blr.vsnl.net.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1] msgsnd (int, struct msgbuf *, int, int) INTERFACE ERROR !!

[2] msgsnd() has "struct msgbuf*" as its 2nd parameter. When I tried to write an application which uses message queues for IPC i declared my message queue buffer as -

struct my_msgq_buf
{
    long mtype;
    char *name;
    double amount;
};

I allocated the memory of name dynamically using "malloc" and wrote into the message Queue using msgsnd. And the msgsnd returns successfully. When I do an msgrcv with the above structure type, I always recieve NULL values in my structure buffer !! 

But, When I use the structure as declared below -

struct my_msgq_buf
{
    long mtype;
    char name[30];
    double amount;
};

Every thing interstingly seems to be working fine.! The interface for msgsnd and msgrcv should have "void *" pointers rather than having a "struct msgbuf *" as parameters.

[3] Kernel
[4] 2.4.7-10 
[5] 
[6]
[7] i586. Intel Pentium 166 MHz MMX.
[8]

