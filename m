Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbREVOkx>; Tue, 22 May 2001 10:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbREVOkn>; Tue, 22 May 2001 10:40:43 -0400
Received: from web13405.mail.yahoo.com ([216.136.175.63]:29457 "HELO
	web13405.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261771AbREVOkb>; Tue, 22 May 2001 10:40:31 -0400
Message-ID: <20010522144030.63670.qmail@web13405.mail.yahoo.com>
Date: Tue, 22 May 2001 07:40:30 -0700 (PDT)
From: Tommy Hallgren <thallgren@yahoo.com>
Subject: Re: [PATCH] struct char_device
To: viro@math.psu.edu, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander!

If I'm not entirely mistaken, this:

+ if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) == 
+ SLAB_CTOR_CONSTRUCTOR) 
+ { 
+ memset(cdev, 0, sizeof(*cdev)); 
+ sema_init(&cdev->sem, 1); 
+ } 
+} 

could be replaced with this:

+ if ((flags & SLAB_CTOR_CONSTRUCTOR) == SLAB_CTOR_CONSTRUCTOR) 
+ { 
+ memset(cdev, 0, sizeof(*cdev)); 
+ sema_init(&cdev->sem, 1); 
+ } 
+} 

Regards, Tommy


__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
