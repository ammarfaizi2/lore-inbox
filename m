Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbSLBPKS>; Mon, 2 Dec 2002 10:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbSLBPKS>; Mon, 2 Dec 2002 10:10:18 -0500
Received: from mail.wincom.net ([209.216.129.3]:39684 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id <S262712AbSLBPKR>;
	Mon, 2 Dec 2002 10:10:17 -0500
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, trog@wincom.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 02 Dec 2002 10:18:11 -0500
Subject: Re: ATAPI DMA timeouts showing up in logs
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3deb797f.41fc.0@wincom.net>
X-User-Info: 129.9.27.145
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, 1970-01-01 at 05:59, Dennis Grant wrote:

>> Now that I've got the proper IDE driver in place (2.4.20rc4)
>> and the master drive on the primary interface is running at
>> a full ATA133, these have started showing up in the logs - 
>> 2 or 3 a day:

> My guess is its the IDE command/DMA sequence bug that Khalid
> fixed in -ac. Some drives also take a very long time on 
> retrying blocks and that might cause a timeout/reset too.

OK.

Interestingly enough, the drive wasn't being used at all during the timeframe
when the messages show up - at least, not explictly. Perhaps some random process
was polling the drive....

Alan, I tried 2.4.20rc4-ac1 but while the patch took, it wouldn't compile. I'll
try again later and fwd where the error was. (I don't have access to that machine
at the moment)

>> This last one is the only indication that something might be >> amiss - the
two instances of "invalid argument" Other than
>> that, the drive appears to work just fine.

>Those are ones CD-ROM's dont support

Ah, OK. Perhaps hdparm shouldn't try them then. :)

Thanks.

DG
