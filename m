Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284280AbRLBTM3>; Sun, 2 Dec 2001 14:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284281AbRLBTMU>; Sun, 2 Dec 2001 14:12:20 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:15972 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S284282AbRLBTMG> convert rfc822-to-8bit; Sun, 2 Dec 2001 14:12:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>,
        andrew may <acmay@acmay.homeip.net>
Subject: Re: 2.4.17pre2: devfs: devfs_mk_dir(printers): could not append to dir: dffe45c0 "", err: -17
Date: Sun, 2 Dec 2001 20:10:30 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16A6LR-00042s-00@mrvdom02.schlund.de> <20011201180940.B21185@ecam.san.rr.com> <200112021847.fB2IlmZ11175@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200112021847.fB2IlmZ11175@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Ac1n-0001Bd-00@mrvdom00.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<-snip->

> This appears reasonable. However, if they call this initialisation
> code twice, it's a bug.


I found the reason for these messages. It has a boot-script source.
Mandrake stores the attributes of device nodes in /lib/dev-state.
This directory is copied into /dev directly before devfsd is started.

If there is a device file in /lib/dev-state it is created in /dev even before 
the driver is loaded.
When the driver is loaded it tries again to create the node and the message 
appears. 
Thanks for your suggestions and remarks.

greetings 

Christian

