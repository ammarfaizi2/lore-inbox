Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265237AbRFUVVF>; Thu, 21 Jun 2001 17:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbRFUVUz>; Thu, 21 Jun 2001 17:20:55 -0400
Received: from sncgw.nai.com ([161.69.248.229]:56494 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265237AbRFUVUm>;
	Thu, 21 Jun 2001 17:20:42 -0400
Message-ID: <XFMail.20010621142352.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.7.Linux:20010621142352:1037=_"
In-Reply-To: <XFMail.20010621123002.davidel@xmailserver.org>
Date: Thu, 21 Jun 2001 14:23:52 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: RE: do_select() improvement ...
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.4.7.Linux:20010621142352:1037=_
Content-Type: text/plain; charset=us-ascii


On 21-Jun-2001 Davide Libenzi wrote:
>                         off = i / __NFDBITS;
> !                       if (!(i & (__NFDBITS - 1))) {
> !                               bits = BITS(fds, off);
> !                               if (!bits) {
> !                                       i += __NFDBITS;
> !                                       continue;
> !                               }


This is wrong.



>                         off = i / __NFDBITS;
> !                       if (!(i & (__NFDBITS - 1))) {
> !                               bits = BITS(fds, off);
> !                               if (!bits) {
> !                                       i += __NFDBITS - 1;
> !                                       continue;
> !                               }

This is right.





- Davide


--_=XFMail.1.4.7.Linux:20010621142352:1037=_
Content-Disposition: attachment; filename="select.c.diff"
Content-Transfer-Encoding: base64
Content-Description: select.c.diff
Content-Type: application/octet-stream; name=select.c.diff; SizeOnDisk=597

LS0tIHNlbGVjdC5vcmlnLmMJVGh1IEp1biAyMSAwODo1MjowNCAyMDAxCisrKyBzZWxlY3QuYwlU
aHUgSnVuIDIxIDEyOjA5OjI1IDIwMDEKQEAgLTE2NSw2ICsxNjUsNyBAQAogCXBvbGxfdGFibGUg
dGFibGUsICp3YWl0OwogCWludCByZXR2YWwsIGksIG9mZjsKIAlsb25nIF9fdGltZW91dCA9ICp0
aW1lb3V0OworCXVuc2lnbmVkIGxvbmcgYml0czsKIAogIAlyZWFkX2xvY2soJmN1cnJlbnQtPmZp
bGVzLT5maWxlX2xvY2spOwogCXJldHZhbCA9IG1heF9zZWxlY3RfZmQobiwgZmRzKTsKQEAgLTE4
Nyw3ICsxODgsMTQgQEAKIAkJCXN0cnVjdCBmaWxlICpmaWxlOwogCiAJCQlvZmYgPSBpIC8gX19O
RkRCSVRTOwotCQkJaWYgKCEoYml0ICYgQklUUyhmZHMsIG9mZikpKQorCQkJaWYgKCEoaSAmIChf
X05GREJJVFMgLSAxKSkpIHsKKwkJCQliaXRzID0gQklUUyhmZHMsIG9mZik7CisJCQkJaWYgKCFi
aXRzKSB7CisJCQkJCWkgKz0gX19ORkRCSVRTIC0gMTsKKwkJCQkJY29udGludWU7CisJCQkJfQor
CQkJfQorCQkJaWYgKCEoYml0ICYgYml0cykpCiAJCQkJY29udGludWU7CiAJCQlmaWxlID0gZmdl
dChpKTsKIAkJCW1hc2sgPSBQT0xMTlZBTDsK

--_=XFMail.1.4.7.Linux:20010621142352:1037=_--
End of MIME message
