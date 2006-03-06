Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWCFVhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWCFVhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWCFVhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:37:23 -0500
Received: from mail.gmx.de ([213.165.64.20]:44691 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932367AbWCFVhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:37:23 -0500
X-Authenticated: #15171491
From: "Timo Schroeter" <timsch@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: AMD64 X2 lost ticks on PM timer
Date: Mon, 6 Mar 2006 22:36:57 +0100
Message-ID: <000001c64166$1853c2d0$0100000a@xin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
In-Reply-To: <20060306173659.GA12970@halcrow.us>
Thread-Index: AcZBRVkZUHL7pKaQRuqCxqtOWx/oWAAH547Q
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the same problem with my Tyan K8E Board. I've connected 2 WD raptor
to the onboard SATA ports (nForce 4, RAID0 md). I noticed that my server
hung up this night, after reboot and checking the logfiles I found the same
messages:

time.c: Lost 141 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 127 timer tick(s)! rip poll_idle+0xa/0x19)
time.c: Lost 92 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 64 timer tick(s)! rip poll_idle+0xa/0x19)

I dont use the onboard nFORCE4 NIC but the BROADCOM one. 

I ran ./trtc with the following results:

1141680789:835638: rtc 256 int 0 0 (=0)
1141680790:104663: rtc 464 int 269 0 (=269)
1141680790:604729: rtc 448 int 501 0 (=501)
1141680791:104795: rtc 464 int 500 0 (=500)
1141680791:604862: rtc 448 int 500 0 (=500)
1141680792:104927: rtc 464 int 500 0 (=500)
1141680792:604994: rtc 448 int 500 0 (=500)
1141680793:105060: rtc 464 int 500 0 (=500)
1141680793:605126: rtc 448 int 500 0 (=500)
1141680794:105192: rtc 464 int 501 0 (=501)
1141680794:605259: rtc 448 int 500 0 (=500)
1141680795:105326: rtc 464 int 500 0 (=500)
1141680795:605392: rtc 448 int 500 0 (=500)
1141680796:105458: rtc 464 int 500 0 (=500)
1141680796:605525: rtc 448 int 500 0 (=500)
1141680797:105592: rtc 464 int 500 0 (=500)
1141680797:605658: rtc 448 int 501 0 (=501)
1141680798:105725: rtc 464 int 500 0 (=500)

I wonder if my server was frozen because of this error. If there will be no
fix soon, I think ist better to get a PCIexpress SATA2 card :(

Regards,

Timo Schroeter

