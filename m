Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbUKLP03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbUKLP03 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 10:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbUKLP03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 10:26:29 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:16572 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S262551AbUKLP0X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 10:26:23 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-11.tower-45.messagelabs.com!1100273181!7365734!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: PROMISE Ultra133 TX2 (PDC20269)
Date: Fri, 12 Nov 2004 10:26:20 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC4073@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROMISE Ultra133 TX2 (PDC20269)
Thread-Index: AcTIynXlYycoM0sMSI+KDDSOq3wTdgAASVPg
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Enrico Bartky" <DOSProfi@web.de>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrmm, I have never seen that syntax, have you tried

hdparm -X68 /dev/hde (udma 4)
Or
hdparm -X69 /dev/hde (udma 5)

What type of disk are you using?

root@p500:~# hdparm -X69 /dev/hde
/dev/hde:
 setting xfermode to 69 (UltraDMA mode5)
root@p500:~# hdparm -X68 /dev/hde
/dev/hde:
 setting xfermode to 68 (UltraDMA mode4)
root@p500:~# hdparm -X67 /dev/hde
/dev/hde:
 setting xfermode to 67 (UltraDMA mode3)
root@p500:~# hdparm -X69 /dev/hde

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Enrico Bartky
Sent: Friday, November 12, 2004 10:14 AM
To: linux-kernel@vger.kernel.org
Subject: PROMISE Ultra133 TX2 (PDC20269)

Hello,

I have the following problem with my controller:

I have attached a 8 GB UDMA4 Harddisk, but it works only with UDMA2. The
controller BIOS displays the right mode (4), but in the kernel dmesg it
comes with pio. after i execute hdparm -I /dev/hde it says:

... udma2* udma3 udma4

If I try to force the UDMA4 mode with hdparm -Xudma4 /dev/hde , ...
theres no difference. The harddisk leaves at udma2.

What can I do?
I have tried 2.4.26, 2.6.9, 2.6.10-rc1...

Can you help me?

Thanx, EnricoB
________________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt neu bei WEB.DE FreeMail: http://freemail.web.de/?mc=021193

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
