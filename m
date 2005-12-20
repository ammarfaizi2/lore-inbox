Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVLTHBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVLTHBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 02:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVLTHBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 02:01:09 -0500
Received: from [202.125.80.34] ([202.125.80.34]:34446 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1750815AbVLTHBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 02:01:08 -0500
Content-class: urn:content-classes:message
Subject: RE: Kernel interrupts disable at user level - RIGHT/ WRONG - Help
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C60532.ABB4FB4A"
Date: Tue, 20 Dec 2005 12:27:13 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B223292@mail.esn.co.in>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel interrupts disable at user level - RIGHT/ WRONG - Help
Thread-Index: AcYEwxZNBhb26Q2gTO6rJcCXMXsuwQAbKqPw
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C60532.ABB4FB4A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Dear Alan,

I want the contents of A, B, C, D registers of CMOS mapped registers.
But instead the driver gives the details about the bit masks of few of =
register A, B only.
The others are NOT available.=20

I would also require to retrieve the day of the week info in RTC =
information.=20
I tried the /dev/rtc but I don't get it there.

at the same time, I am able to get the entire CMOS information using the =
application attached which does not use any driver interface and instead =
use the ports directly.
But, the application tried to disable the interrupts on the processor.=20
Suggest me the pros & cons of using this application.

Regards,
Mukund Jampala


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Monday, December 19, 2005 11:13 PM
To: Mukund JB.
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel interrupts disable at user level - RIGHT/ WRONG -
Help


On Llu, 2005-12-19 at 17:45 +0530, Mukund JB. wrote:
> Dear Kernel Developers,
>=20
> I have a requirement of getting the CMOS details at the user level. I =
have identified the interfaces as /dev/nvram & /dev/rtc.
> But, the complete CMOS details are available to the user Applications =
as the driver does not provide the suitable interface to get the =
complete CMOS details.

Then you'll need to enhance the nvram or rtc driver to support the extra
bits you need. What doesn't it provide access to that you require >


------_=_NextPart_001_01C60532.ABB4FB4A
Content-Type: application/octet-stream;
	name="dmpCmos.c"
Content-Transfer-Encoding: base64
Content-Description: dmpCmos.c
Content-Disposition: attachment;
	filename="dmpCmos.c"

LyoNCiogICAgICAgICAgICAgICAgICAgICAgQ01PUyBEVU1QRVINCiogICAgICAgICAgRW5kcmF6
aW5lIGVuZHJhemluZUBwdWxsdGhlcGx1Zy5vcmcNCioNCioNCiogY29tcGlsaW5nIDogZ2NjIGNt
b3NkLmMgLW8gY21vc2Qubw0KKiB1c2FnZSA6ICNjbW9zZCA+IGNtb3MuZHVtcA0KKg0KKi8NCg0K
I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8YXNtL2lv
Lmg+DQoNCg0KaW50IG1haW4gKCkNCnsNCiAgICAgICAgaW50IGk7DQoNCiAgICAgICAgaWYgKGlv
cGVybSgweDcwLCAyLCAxKSkgICAvL0FzayBQZXJtaXNzaW9uIChzZXQgdG8gMSkgDQogICAgICAg
IHsgICAgICAgICAgICAgICAgICAgICAgICAgLy9mb3IgcG9ydHMgMHg3MCBhbmQgMHg3MQ0KICAg
ICAgICAgICAgICAgIHBlcnJvcigiaW9wZXJtIik7DQogICAgICAgICAgICAgICAgZXhpdCAoMSk7
DQogICAgICAgIH0NCg0KICAgICAgICBmb3IgKGk9MDtpPDEyODtpKyspDQogICAgICAgIHsNCiAg
ICAgICAgICBvdXRiKGksMHg3MCk7Ly8gV3JpdGUgdG8gcG9ydCAweDcwDQogICAgICAgICAgdXNs
ZWVwKDEwMDAwMCk7DQogICAgICAgICAgcHJpbnRmKCIlYyIsaW5iKDB4NzEpKTsNCg0KICAgICAg
ICB9DQoNCiAgICAgICAgaWYgKGlvcGVybSgweDcxLCAyLCAwKSkgLy8gV2UgZG9uJ3QgbmVlZCBQ
ZXJtaXNzaW9uIGFueW1vcmUNCiAgICAgICAgeyAgICAgICAgICAgICAgICAgICAgICAgIC8vIChz
ZXQgcGVybWlzc2lvbnMgdG8gMCkuDQogICAgICAgICAgICAgICAgIHBlcnJvcigiaW9wZXJtIik7
DQogICAgICAgICAgICAgICAgIGV4aXQoMSk7DQogICAgICAgIH0NCg0KICAgICAgICBleGl0ICgw
KTsvLyBRdWl0DQp9

------_=_NextPart_001_01C60532.ABB4FB4A--
