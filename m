Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSHYL66>; Sun, 25 Aug 2002 07:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSHYL66>; Sun, 25 Aug 2002 07:58:58 -0400
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:28399 "HELO
	dardhal.mired.net") by vger.kernel.org with SMTP id <S317299AbSHYL65>;
	Sun, 25 Aug 2002 07:58:57 -0400
Date: Sun, 25 Aug 2002 14:03:05 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: serious packet loss in 25Mbps load,frame size 64byte,duration 60 second. tested with smartbits
Message-ID: <20020825120305.GA7892@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020825104438.86663.qmail@web14508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020825104438.86663.qmail@web14508.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 25 August 2002, at 03:44:38 -0700,
Bergs wrote:

> My kernel is 2.4.16.
> performance of eepro100 driver 1.23b version.
> when the data load is 25% of
> 100Mbps,bi-directional,64byte frame size,and the test
> duration is 60 second,the test result display that
> serious packet loss take place. when the duration
> decrease to 10 second,the other test condition matain
> unchanged,no packet losss.
> 
The first should be to identify where the problem is. For example, run a
"vmstat 1" during the test to see if something looks unreasonable. At 25
Mbps bidirectional with a packet size of 64 bytes, there are nearly
50000 packets coming in and another 50000 going out. If there is an
interrupt for each packet sent/received (don't seem to be the case, at
least checking default module parameters for eepro100) you system will
have to deal with up to 100000 interrupts/second, quite a lot for a slow
system.

Hope it (somehow) helps :)

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Woody (Linux 2.4.19-pre6aa1)
