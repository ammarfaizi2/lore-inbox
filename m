Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVKIOBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVKIOBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVKIOBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:01:48 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:61486
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750777AbVKIOBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:01:47 -0500
Message-Id: <43720F95.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 15:02:45 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/39] NLKD - task create/destroy notification
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com> <43720F5E.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartCDEFF195.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartCDEFF195.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

A mechanism to allow debuggers to learn about starting/dying tasks.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__PartCDEFF195.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-nlkd-notify-task.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-nlkd-notify-task.patch"

QSBtZWNoYW5pc20gdG8gYWxsb3cgZGVidWdnZXJzIHRvIGxlYXJuIGFib3V0IHN0YXJ0aW5nL2R5
aW5nIHRhc2tzLgoKU2lnbmVkLU9mZi1CeTogSmFuIEJldWxpY2ggPGpiZXVsaWNoQG5vdmVsbC5j
b20+CgpJbmRleDogMi42LjE0LW5sa2QvaW5jbHVkZS9saW51eC9zY2hlZC5oCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
LS0tIDIuNi4xNC1ubGtkLm9yaWcvaW5jbHVkZS9saW51eC9zY2hlZC5oCTIwMDUtMTEtMDkgMTA6
NDA6MTcuMDAwMDAwMDAwICswMTAwCisrKyAyLjYuMTQtbmxrZC9pbmNsdWRlL2xpbnV4L3NjaGVk
LmgJMjAwNS0xMS0wNCAxNjoxOTozNC4wMDAwMDAwMDAgKzAxMDAKQEAgLTM0LDYgKzM0LDcgQEAK
ICNpbmNsdWRlIDxsaW51eC9wZXJjcHUuaD4KICNpbmNsdWRlIDxsaW51eC90b3BvbG9neS5oPgog
I2luY2x1ZGUgPGxpbnV4L3NlY2NvbXAuaD4KKyNpbmNsdWRlIDxsaW51eC9ub3RpZmllci5oPgog
CiAjaW5jbHVkZSA8bGludXgvYXV4dmVjLmg+CS8qIEZvciBBVF9WRUNUT1JfU0laRSAqLwogCkBA
IC0xMTA5LDYgKzExMTAsMTEgQEAgZXh0ZXJuIGludCBkb19leGVjdmUoY2hhciAqLCBjaGFyIF9f
dXNlcgogZXh0ZXJuIGxvbmcgZG9fZm9yayh1bnNpZ25lZCBsb25nLCB1bnNpZ25lZCBsb25nLCBz
dHJ1Y3QgcHRfcmVncyAqLCB1bnNpZ25lZCBsb25nLCBpbnQgX191c2VyICosIGludCBfX3VzZXIg
Kik7CiB0YXNrX3QgKmZvcmtfaWRsZShpbnQpOwogCisjZGVmaW5lIFRBU0tfTkVXIDEKKyNkZWZp
bmUgVEFTS19ERUxFVEUgMgorCitleHRlcm4gc3RydWN0IG5vdGlmaWVyX2Jsb2NrICp0YXNrX25v
dGlmaWVyX2xpc3Q7CisKIGV4dGVybiB2b2lkIHNldF90YXNrX2NvbW0oc3RydWN0IHRhc2tfc3Ry
dWN0ICp0c2ssIGNoYXIgKmZyb20pOwogZXh0ZXJuIHZvaWQgZ2V0X3Rhc2tfY29tbShjaGFyICp0
bywgc3RydWN0IHRhc2tfc3RydWN0ICp0c2spOwogCkluZGV4OiAyLjYuMTQtbmxrZC9rZXJuZWwv
Zm9yay5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KLS0tIDIuNi4xNC1ubGtkLm9yaWcva2VybmVsL2ZvcmsuYwkyMDA1
LTExLTA5IDEwOjQwOjE3LjAwMDAwMDAwMCArMDEwMAorKysgMi42LjE0LW5sa2Qva2VybmVsL2Zv
cmsuYwkyMDA1LTExLTA0IDE2OjE5OjM0LjAwMDAwMDAwMCArMDEwMApAQCAtNjQsNiArNjQsOSBA
QCBERUZJTkVfUEVSX0NQVSh1bnNpZ25lZCBsb25nLCBwcm9jZXNzX2NvCiAKIEVYUE9SVF9TWU1C
T0wodGFza2xpc3RfbG9jayk7CiAKK3N0cnVjdCBub3RpZmllcl9ibG9jayAqdGFza19ub3RpZmll
cl9saXN0ID0gTlVMTDsKK0VYUE9SVF9TWU1CT0wodGFza19ub3RpZmllcl9saXN0KTsKKwogaW50
IG5yX3Byb2Nlc3Nlcyh2b2lkKQogewogCWludCBjcHU7CkBAIC0xMDgsNiArMTExLDggQEAgRVhQ
T1JUX1NZTUJPTChmcmVlX3Rhc2spOwogCiB2b2lkIF9fcHV0X3Rhc2tfc3RydWN0KHN0cnVjdCB0
YXNrX3N0cnVjdCAqdHNrKQogeworCW5vdGlmaWVyX2NhbGxfY2hhaW4oJnRhc2tfbm90aWZpZXJf
bGlzdCwgVEFTS19ERUxFVEUsIHRzayk7CisKIAlXQVJOX09OKCEodHNrLT5leGl0X3N0YXRlICYg
KEVYSVRfREVBRCB8IEVYSVRfWk9NQklFKSkpOwogCVdBUk5fT04oYXRvbWljX3JlYWQoJnRzay0+
dXNhZ2UpKTsKIAlXQVJOX09OKHRzayA9PSBjdXJyZW50KTsKQEAgLTEyNzksNiArMTI4NCw4IEBA
IGxvbmcgZG9fZm9yayh1bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLAogCQkJc2V0X3Rza190aHJl
YWRfZmxhZyhwLCBUSUZfU0lHUEVORElORyk7CiAJCX0KIAorCQlub3RpZmllcl9jYWxsX2NoYWlu
KCZ0YXNrX25vdGlmaWVyX2xpc3QsIFRBU0tfTkVXLCBwKTsKKwogCQlpZiAoIShjbG9uZV9mbGFn
cyAmIENMT05FX1NUT1BQRUQpKQogCQkJd2FrZV91cF9uZXdfdGFzayhwLCBjbG9uZV9mbGFncyk7
CiAJCWVsc2UK

--=__PartCDEFF195.0__=--
