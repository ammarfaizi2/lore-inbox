Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290184AbSALAWf>; Fri, 11 Jan 2002 19:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290185AbSALAWY>; Fri, 11 Jan 2002 19:22:24 -0500
Received: from mail5.mx.voyager.net ([216.93.66.204]:36359 "EHLO
	mail5.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S290182AbSALAWI>; Fri, 11 Jan 2002 19:22:08 -0500
Message-ID: <3C3F81C8.9744C16A@megsinet.net>
Date: Fri, 11 Jan 2002 18:22:32 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Taming OOM killer, 2.4.17-rc1
In-Reply-To: <20011212094246.O4801@athlon.random> <3C1AB4B4.A24A0A5@megsinet.net> <200201112113.g0BLDFE24964@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: multipart/mixed;
 boundary="------------44B4B49D7F7E9B591209EA49"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------44B4B49D7F7E9B591209EA49
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Denis,

This patch was a feeble attempt at fixing a real VM problem by masking what was
really going on.

There are many "better" solution than this old patch

AA has a great VM patch
Rik has an rmap patch that looks promising

and my latest "simple" fix is attached for 2.4.17 but should apply to 2.4.18-pre

Thanks for looking at this old one though.

Martin

BTW: w/ this patch you no longer need to Tame the OOM killer
--------------44B4B49D7F7E9B591209EA49
Content-Type: application/octet-stream;
 name="vmscan.patch.2.4.17.d"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="vmscan.patch.2.4.17.d"

LS0tIGxpbnV4LnZpcmdpbi9tbS92bXNjYW4uYwlNb24gRGVjIDMxIDEyOjQ2OjI1IDIwMDEK
KysrIGxpbnV4L21tL3Ztc2Nhbi5jCUZyaSBKYW4gMTEgMTg6MDM6MDUgMjAwMgpAQCAtMzk0
LDkgKzM5NCw5IEBACiAJCWlmIChQYWdlRGlydHkocGFnZSkgJiYgaXNfcGFnZV9jYWNoZV9m
cmVlYWJsZShwYWdlKSAmJiBwYWdlLT5tYXBwaW5nKSB7CiAJCQkvKgogCQkJICogSXQgaXMg
bm90IGNyaXRpY2FsIGhlcmUgdG8gd3JpdGUgaXQgb25seSBpZgotCQkJICogdGhlIHBhZ2Ug
aXMgdW5tYXBwZWQgYmVhdXNlIGFueSBkaXJlY3Qgd3JpdGVyCisJCQkgKiB0aGUgcGFnZSBp
cyB1bm1hcHBlZCBiZWNhdXNlIGFueSBkaXJlY3Qgd3JpdGVyCiAJCQkgKiBsaWtlIE9fRElS
RUNUIHdvdWxkIHNldCB0aGUgUEdfZGlydHkgYml0ZmxhZwotCQkJICogb24gdGhlIHBoaXNp
Y2FsIHBhZ2UgYWZ0ZXIgaGF2aW5nIHN1Y2Nlc3NmdWxseQorCQkJICogb24gdGhlIHBoeXNp
Y2FsIHBhZ2UgYWZ0ZXIgaGF2aW5nIHN1Y2Nlc3NmdWxseQogCQkJICogcGlubmVkIGl0IGFu
ZCBhZnRlciB0aGUgSS9PIHRvIHRoZSBwYWdlIGlzIGZpbmlzaGVkLAogCQkJICogc28gdGhl
IGRpcmVjdCB3cml0ZXMgdG8gdGhlIHBhZ2UgY2Fubm90IGdldCBsb3N0LgogCQkJICovCkBA
IC00ODAsMTEgKzQ4MCwxNCBAQAogCiAJCQkvKgogCQkJICogQWxlcnQhIFdlJ3ZlIGZvdW5k
IHRvbyBtYW55IG1hcHBlZCBwYWdlcyBvbiB0aGUKLQkJCSAqIGluYWN0aXZlIGxpc3QsIHNv
IHdlIHN0YXJ0IHN3YXBwaW5nIG91dCBub3chCisJCQkgKiBpbmFjdGl2ZSBsaXN0LgorCQkJ
ICogTW92ZSByZWZlcmVuY2VkIHBhZ2VzIHRvIHRoZSBhY3RpdmUgbGlzdC4KIAkJCSAqLwot
CQkJc3Bpbl91bmxvY2soJnBhZ2VtYXBfbHJ1X2xvY2spOwotCQkJc3dhcF9vdXQocHJpb3Jp
dHksIGdmcF9tYXNrLCBjbGFzc3pvbmUpOwotCQkJcmV0dXJuIG5yX3BhZ2VzOworCQkJaWYg
KFBhZ2VSZWZlcmVuY2VkKHBhZ2UpICYmICFQYWdlTG9ja2VkKHBhZ2UpKSB7CisJCQkJZGVs
X3BhZ2VfZnJvbV9pbmFjdGl2ZV9saXN0KHBhZ2UpOworCQkJCWFkZF9wYWdlX3RvX2FjdGl2
ZV9saXN0KHBhZ2UpOworCQkJfQorCQkJY29udGludWU7CiAJCX0KIAogCQkvKgpAQCAtNTIx
LDYgKzUyNCw5IEBACiAJfQogCXNwaW5fdW5sb2NrKCZwYWdlbWFwX2xydV9sb2NrKTsKIAor
CWlmIChtYXhfbWFwcGVkIDw9IDAgJiYgKG5yX3BhZ2VzID4gMCB8fCBwcmlvcml0eSA8IERF
Rl9QUklPUklUWSkpCisJCXN3YXBfb3V0KHByaW9yaXR5LCBnZnBfbWFzaywgY2xhc3N6b25l
KTsKKwogCXJldHVybiBucl9wYWdlczsKIH0KIAo=
--------------44B4B49D7F7E9B591209EA49--

