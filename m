Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310663AbSCHDC2>; Thu, 7 Mar 2002 22:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310666AbSCHDCT>; Thu, 7 Mar 2002 22:02:19 -0500
Received: from maillog.promise.com.tw ([210.244.60.166]:45048 "EHLO
	maillog.promise.com.tw") by vger.kernel.org with ESMTP
	id <S310663AbSCHDCG>; Thu, 7 Mar 2002 22:02:06 -0500
Message-ID: <010c01c1c64d$85550e90$59cca8c0@hank>
From: "Hank Yang" <hanky@promise.com.tw>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>,
        "Linus Chen" <linusc@promise.com.tw>
In-Reply-To: <E16j9pb-0004dV-00@the-village.bc.nu>
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Date: Fri, 8 Mar 2002 11:01:18 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     That's because the linux-kernel misunderstand the raid controller
> > to IDE controller. If do so, The raid driver will be unstable when
> > be loaded.
> >     So we must to prevent the raio controller to be as IDE controller
> > here.
> 
> The ataraid driver in the standard kernel requires the IDE drive is seen
> by the ide layer otherwise ataraid cannot bind it into a raid module

First, the IDE driver doesn't check the controller's class code is raid
controller (0x0104) or other controller(0x0180). So If our raid controller
(FastTrak series) be seen by IDE driver. It will snatch the same IRQ.
It will cause our trouble.
It's pity that the linux kernel could agree this point also.

Begards
Hank Yang

