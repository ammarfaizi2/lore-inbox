Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284164AbRLARnh>; Sat, 1 Dec 2001 12:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284169AbRLARn1>; Sat, 1 Dec 2001 12:43:27 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:58083 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284164AbRLARnO>; Sat, 1 Dec 2001 12:43:14 -0500
Date: Sat, 1 Dec 2001 19:48:01 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] if (foo) kfree(foo) /fs cleanup + reverted JBD code path
 changes
In-Reply-To: <87667qrhg8.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.33.0112011942340.14914-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, OGAWA Hirofumi wrote:
> In all failed cases, this message will be outputted. I think I shouldn't do
> so. (or remove this message.)

I found all sorts of interesting things in my little adventure...
Heres an interesting one;

drivers/fc4/fc.c:

 	l.fcmds = kmalloc (count * sizeof(fcp_cmnd), GFP_KERNEL);
	if (!l.fcmds) {
                kfree (l.fcmds);
                printk ("FC: Cannot allocate memory for forcing offline\n");
                return -ENOMEM;
        }


