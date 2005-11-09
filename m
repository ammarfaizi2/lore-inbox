Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVKIOAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVKIOAK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVKIOAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:00:10 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:41006
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750771AbVKIOAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:00:08 -0500
Message-Id: <43720F32.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 15:01:06 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH 5/39] NLKD/x86-64 - early/late CPU up/down notification
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part6A485632.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part6A485632.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

x86_64-specific part of the new mechanism to allow debuggers to learn
about starting/dying CPUs as early/late as possible.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__Part6A485632.1__=
Content-Type: application/octet-stream; name="linux-2.6.14-nlkd-notify-cpu-x86_64.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-nlkd-notify-cpu-x86_64.patch"

eDg2XzY0LXNwZWNpZmljIHBhcnQgb2YgdGhlIG5ldyBtZWNoYW5pc20gdG8gYWxsb3cgZGVidWdn
ZXJzIHRvIGxlYXJuCmFib3V0IHN0YXJ0aW5nL2R5aW5nIENQVXMgYXMgZWFybHkvbGF0ZSBhcyBw
b3NzaWJsZS4KCkZyb206IEphbiBCZXVsaWNoIDxqYmV1bGljaEBub3ZlbGwuY29tPgoKSW5kZXg6
IDIuNi4xNC1ubGtkL2FyY2gveDg2XzY0L2tlcm5lbC9wcm9jZXNzLmMKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0g
Mi42LjE0LW5sa2Qub3JpZy9hcmNoL3g4Nl82NC9rZXJuZWwvcHJvY2Vzcy5jCTIwMDUtMTEtMDkg
MTA6NDA6MTcuMDAwMDAwMDAwICswMTAwCisrKyAyLjYuMTQtbmxrZC9hcmNoL3g4Nl82NC9rZXJu
ZWwvcHJvY2Vzcy5jCTIwMDUtMTEtMDQgMTY6MTk6MzMuMDAwMDAwMDAwICswMTAwCkBAIC0xNjQs
NiArMTY0LDcgQEAgREVDTEFSRV9QRVJfQ1BVKGludCwgY3B1X3N0YXRlKTsKIHN0YXRpYyBpbmxp
bmUgdm9pZCBwbGF5X2RlYWQodm9pZCkKIHsKIAlpZGxlX3Rhc2tfZXhpdCgpOworCWNwdV9ub3Rp
ZnkoQ1BVX0RZSU5HKTsKIAl3YmludmQoKTsKIAltYigpOwogCS8qIEFjayBpdCAqLwpJbmRleDog
Mi42LjE0LW5sa2QvYXJjaC94ODZfNjQva2VybmVsL3NtcGJvb3QuYwo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSAy
LjYuMTQtbmxrZC5vcmlnL2FyY2gveDg2XzY0L2tlcm5lbC9zbXBib290LmMJMjAwNS0xMS0wOSAx
MDo0MDoxNy4wMDAwMDAwMDAgKzAxMDAKKysrIDIuNi4xNC1ubGtkL2FyY2gveDg2XzY0L2tlcm5l
bC9zbXBib290LmMJMjAwNS0xMS0wNCAxNjoxOTozMy4wMDAwMDAwMDAgKzAxMDAKQEAgLTQwLDcg
KzQwLDcgQEAKIAogI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPgogI2luY2x1ZGUgPGxpbnV4L2lu
aXQuaD4KLQorI2luY2x1ZGUgPGxpbnV4L2NwdS5oPgogI2luY2x1ZGUgPGxpbnV4L21tLmg+CiAj
aW5jbHVkZSA8bGludXgva2VybmVsX3N0YXQuaD4KICNpbmNsdWRlIDxsaW51eC9zbXBfbG9jay5o
PgpAQCAtNDc5LDYgKzQ3OSw4IEBAIHZvaWQgX19jcHVpbml0IHN0YXJ0X3NlY29uZGFyeSh2b2lk
KQogCS8qIG90aGVyd2lzZSBnY2Mgd2lsbCBtb3ZlIHVwIHRoZSBzbXBfcHJvY2Vzc29yX2lkIGJl
Zm9yZSB0aGUgY3B1X2luaXQgKi8KIAliYXJyaWVyKCk7CiAKKwljcHVfbm90aWZ5KENQVV9BTElW
RSk7CisKIAlEcHJpbnRrKCJjcHUgJWQ6IHNldHRpbmcgdXAgYXBpYyBjbG9ja1xuIiwgc21wX3By
b2Nlc3Nvcl9pZCgpKTsgCQogCXNldHVwX3NlY29uZGFyeV9BUElDX2Nsb2NrKCk7CiAK

--=__Part6A485632.1__=--
