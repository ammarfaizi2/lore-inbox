Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbSLCGEG>; Tue, 3 Dec 2002 01:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbSLCGEG>; Tue, 3 Dec 2002 01:04:06 -0500
Received: from mail.wincom.net ([209.216.129.3]:43784 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id <S265099AbSLCGEF>;
	Tue, 3 Dec 2002 01:04:05 -0500
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: linux-kernel@vger.kernel.org
Date: Tue, 03 Dec 102 01:08:33 -0500
Subject: Re: [OT] *SOLVED* Slow FTP Transfers between 2.4 machines
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3dec4aff.50ae.0@wincom.net>
X-User-Info: 24.57.83.120
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Rcpt-To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This _might_ be OT... certainly I'm not entirely ready to lay
>> this at the feet of the kernel just yet. 

Oi, and a damn good thing I didn't too.

Mea culpa. I'm a dumbass. :(

The problem turned out to be this:

Box A gets its IP address and other routing information from DHCP, via the cable
modem

Box B gets its IP address and other routing information from DHCP, via the cable
modem

See where this is going?

Yup, all traffic between the two boxes was going via the cable modem and the
upstream gateway. The cable modem has an upload limit of roughly 40k/sec, so...
there it is.

Adding the appropriate routing information to each box to tell it that the other
was local resulted in an immediate jump in FTP  transfer rates to 1000k/sec,
which I think is the max speed on a 10mbs line. 

Doh!

I'll just slink off into this corner over here and be quiet for a while.

Thanks to "ManMower" who caught the problem, and to everybody else who responded.


DG
