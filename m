Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132170AbRCVTvr>; Thu, 22 Mar 2001 14:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132169AbRCVTvi>; Thu, 22 Mar 2001 14:51:38 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:24327 "HELO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S132166AbRCVTvX>; Thu, 22 Mar 2001 14:51:23 -0500
Reply-To: <frey@cxau.zko.dec.com>
From: "Martin Frey" <frey@scs.ch>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: kernel_thread vs. zombie
Date: Thu, 22 Mar 2001 11:50:34 -0800
Message-ID: <007801c0b309$5bca3530$90600410@SCHLEPPDOWN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010322184740.17781@mailhost.mipsys.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>The stuff done in daemonize() and the exit_files could need
>>the kernel lock. At least on some 2.2.x version it does,
>>I did not check whether it is still needed on 2.4.
>
>Well, I don't really plan to backport this to 2.2.x. I'll
>try to see if my problem is related to the lack of kernel
>lock, or maybe I have just something else wrong.
>
daemonize() makes calls that are all protected with the
big kernel lock in do_exit(). All usages of daemonize have
the big kernel lock held. So I guess it just needs it.

Please let me know whether you have success if it makes
a difference with having it held.

Martin
