Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265814AbUAMWwB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUAMWts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:49:48 -0500
Received: from mailserver2.hrz.tu-darmstadt.de ([130.83.47.4]:3602 "EHLO
	mailserver2.hrz.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S266217AbUAMWmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:42:54 -0500
Message-Id: <200401132242.i0DMgneK028354@mailserver2.hrz.tu-darmstadt.de>
From: Jens David <dg1kjd@afthd.tu-darmstadt.de>
Organization: FBR Networks Inc.
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IRDA device driver API 2.6 -> 2.4 backport
Date: Tue, 13 Jan 2004 23:42:49 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DR9GTXS3CW30DA88QM5Z"
X-TUD-HRZ-MailScanner: Found to be clean
X-TUD-HRZ-MailScanner-SpamCheck: not spam, SpamAssassin (Wertung=3.31,
	benoetigt 5, MSGID_FROM_MTA_SHORT 3.31)
X-TUD-HRZ-MailScanner-SpamScore: sss
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_DR9GTXS3CW30DA88QM5Z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Jeff, all,

don' t know excactly where to send this to.
I had a little spare time this week as my doctor grounded me, so to
relax I did a bit of kernel hacking and get my notebook working. 8-)

This patch adds the "alloc_irdadev" primitive to Linux-2.4 . Modeled
after and code stolen from Linux-2.6 .
This enables practically drop-in addition of Linux-2.6 IRDA drivers
to Linux-2.4.

This patch is prerequisite for another patch from me which adds
via-ircc to the IRDA driver modules.

Patch against linux-2.4.24-0pre2.1mdk from current Mandrake Cooker.
Should apply to vanilla Linux-2.4.24 as well.

  -- Jens



-- 
Jens David, DG1KJD
Email: dg1kjd@afthd.tu-darmstadt.de
http://www.afthd.tu-darmstadt.de/~dg1kjd
Work: +49 351 80800 527  ---  Home/Mobile: +49 173 6394993





--------------Boundary-00=_DR9GTXS3CW30DA88QM5Z
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-2.4.24-0.pre2.1mdk-irda_device_api26"
Content-Transfer-Encoding: base64
Content-Description: add alloc_irdadev primitive from 2.6 to Linux-2.4
Content-Disposition: attachment; filename="patch-2.4.24-0.pre2.1mdk-irda_device_api26"

LS0tIGxpbnV4LTIuNC4yNC0wLnByZTIuMW1kay5vcmlnL2luY2x1ZGUvbmV0L2lyZGEvaXJkYV9k
ZXZpY2UuaAkyMDAxLTA2LTIwIDAyOjA4OjA1LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi40
LjI0LTAucHJlMi4xbWRrLmNvcHkvaW5jbHVkZS9uZXQvaXJkYS9pcmRhX2RldmljZS5oCTIwMDQt
MDEtMTMgMTI6MTI6NDQuMDAwMDAwMDAwICswMTAwCkBAIC0xNjksNiArMTY5LDcgQEAgaW50ICBp
cmRhX2RldmljZV9zZXRfcmF3X21vZGUoc3RydWN0IG5ldAogaW50ICBpcmRhX2RldmljZV9zZXRf
ZHRyX3J0cyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBpbnQgZHRyLCBpbnQgcnRzKTsKIGludCAg
aXJkYV9kZXZpY2VfY2hhbmdlX3NwZWVkKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIF9fdTMyIHNw
ZWVkKTsKIGludCAgaXJkYV9kZXZpY2Vfc2V0dXAoc3RydWN0IG5ldF9kZXZpY2UgKmRldik7Citz
dHJ1Y3QgbmV0X2RldmljZSAqYWxsb2NfaXJkYWRldihpbnQgc2l6ZW9mX3ByaXYpOwogCiAvKiBE
b25nbGUgaW50ZXJmYWNlICovCiB2b2lkIGlyZGFfZGV2aWNlX3VucmVnaXN0ZXJfZG9uZ2xlKHN0
cnVjdCBkb25nbGVfcmVnICpkb25nbGUpOwotLS0gbGludXgtMi40LjI0LTAucHJlMi4xbWRrLm9y
aWcvbmV0L2lyZGEvaXJkYV9kZXZpY2UuYwkyMDAzLTExLTI4IDE5OjI2OjIxLjAwMDAwMDAwMCAr
MDEwMAorKysgbGludXgtMi40LjI0LTAucHJlMi4xbWRrLmNvcHkvbmV0L2lyZGEvaXJkYV9kZXZp
Y2UuYwkyMDA0LTAxLTExIDAwOjI1OjA5LjAwMDAwMDAwMCArMDEwMApAQCAtNDYxLDYgKzQ2MSwx
NyBAQCBpbnQgaXJkYV9kZXZpY2Vfc2V0dXAoc3RydWN0IG5ldF9kZXZpY2UgCiB9CiAKIC8qCisg
KiBGdW5jaXRvbiAgYWxsb2NfaXJkYWRldiAKKyAqIAlBbGxvY2F0ZXMgYW5kIHNldHMgdXAgYW4g
SVJEQSBkZXZpY2UgaW4gYSBtYW5uZXIgc2ltaWxhciB0bworICogCWFsbG9jX2V0aGVyZGV2Lgor
ICovCitzdHJ1Y3QgbmV0X2RldmljZSAqYWxsb2NfaXJkYWRldihpbnQgc2l6ZW9mX3ByaXYpCit7
CisJcmV0dXJuIGFsbG9jX25ldGRldihzaXplb2ZfcHJpdiwgImlyZGElZCIsIGlyZGFfZGV2aWNl
X3NldHVwKTsKK30KKworCisvKgogICogRnVuY3Rpb24gaXJkYV9kZXZpY2VfdHhxdWV1ZV9lbXB0
eSAoZGV2KQogICoKICAqICAgIENoZWNrIGlmIHRoZXJlIGlzIHN0aWxsIHNvbWUgZnJhbWVzIGlu
IHRoZSB0cmFuc21pdCBxdWV1ZSBmb3IgdGhpcwotLS0gbGludXgtMi40LjI0LTAucHJlMi4xbWRr
Lm9yaWcvbmV0L2lyZGEvaXJzeW1zLmMJMjAwMy0wOC0yNSAxMzo0NDo0NC4wMDAwMDAwMDAgKzAy
MDAKKysrIGxpbnV4LTIuNC4yNC0wLnByZTIuMW1kay5jb3B5L25ldC9pcmRhL2lyc3ltcy5jCTIw
MDQtMDEtMTEgMDA6MjY6NDcuMDAwMDAwMDAwICswMTAwCkBAIC0xNDUsNiArMTQ1LDcgQEAgRVhQ
T1JUX1NZTUJPTChpcmxhcF9jbG9zZSk7CiBFWFBPUlRfU1lNQk9MKGlyZGFfaW5pdF9tYXhfcW9z
X2NhcGFiaWxpZXMpOwogRVhQT1JUX1NZTUJPTChpcmRhX3Fvc19iaXRzX3RvX3ZhbHVlKTsKIEVY
UE9SVF9TWU1CT0woaXJkYV9kZXZpY2Vfc2V0dXApOworRVhQT1JUX1NZTUJPTChhbGxvY19pcmRh
ZGV2KTsKIEVYUE9SVF9TWU1CT0woaXJkYV9kZXZpY2Vfc2V0X21lZGlhX2J1c3kpOwogRVhQT1JU
X1NZTUJPTChpcmRhX2RldmljZV90eHF1ZXVlX2VtcHR5KTsKIAo=

--------------Boundary-00=_DR9GTXS3CW30DA88QM5Z--

