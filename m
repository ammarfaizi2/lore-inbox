Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311287AbSCQEXE>; Sat, 16 Mar 2002 23:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311289AbSCQEWy>; Sat, 16 Mar 2002 23:22:54 -0500
Received: from web10504.mail.yahoo.com ([216.136.130.154]:35087 "HELO
	web10504.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311287AbSCQEWl>; Sat, 16 Mar 2002 23:22:41 -0500
Message-ID: <20020317042241.70303.qmail@web10504.mail.yahoo.com>
Date: Sat, 16 Mar 2002 20:22:41 -0800 (PST)
From: S W <egberts@yahoo.com>
Subject: Re: 2.4.19-pre2 CentaurHauls VIA Samuel 2 stepping 2 SEGFAULT (RESOLVED)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>
Cc: S W <egberts@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E16mLIY-00079l-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I pulled the chipset datasheet for CentaurHauls VIA
Samuel 2 stepping 2.

Two seperate i386/kernel/setup.c fixes things seems to
fix this chipset.

1.  Disabled the Branch Predictor in MSR_VIA_FCR
2.  cachesize=0

Other attempts to fix this were:
3.  Disabling L2 Cache OOP'd so that's not an option.
4.  Disables I-Cache (too slow)
5.  Disables D-Cache OOP'd
6.  Disables Page Directory Cache is a NOP.

I've settled for cachesize=0.

Hope this is not a trend here.

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
