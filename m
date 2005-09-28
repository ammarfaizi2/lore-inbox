Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVI1HDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVI1HDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVI1HDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:03:39 -0400
Received: from mailgate.urz.uni-halle.de ([141.48.3.51]:56461 "EHLO
	mailgate.uni-halle.de") by vger.kernel.org with ESMTP
	id S1751168AbVI1HDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:03:38 -0400
Date: Wed, 28 Sep 2005 09:03:29 +0200 (METDST)
From: Clemens Ladisch <clemens@ladisch.de>
To: Karsten Wiese <annabellesgarden@yahoo.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Enable HPET on VIA8237 southbridge
In-Reply-To: <200509261934.03876.annabellesgarden@yahoo.de>
Message-ID: <Pine.HPX.4.33n.0509280855190.3203-200000@studcom.urz.uni-halle.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="2015913978-1804928587-1127891009=:3203"
X-Scan-Signature: a5d1d8901da1864a140957f50574c644
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2015913978-1804928587-1127891009=:3203
Content-Type: TEXT/PLAIN; charset=US-ASCII

Karsten Wiese wrote:
> Am Montag, 26. September 2005 17:49 schrieb Clemens Ladisch:
> > Karsten Wiese wrote:
> > > if you have that chip on your mainboard and want to play with it's
> > > hpet, this might get you going.
> >
> > I'm using similar code for my ICH5 southbridge, but I patched
> > arch/i386/kernel/acpi/boot.c instead so that the kernel can use it
> > for its own purposes.
>
> The kernel uses the hpet here too with my patch.

Uh, yes.  I wasn't sure where I could add a hook to be called early
enough so that the assignment to hpet_address still takes effect, so I
just unconditionally replaced acpi_parse_hpet.

> Please send me your acpi/boot.c patch.

Attached.

> I guess you setup an ACPI_HPET entry, if none has been found?

This would be a good idea for a patch that would have any chance of
being applied to the kernel.

> Maybe your approach is safer/better,

You didn't yet see it ... ;-)


Regards,
Clemens

--2015913978-1804928587-1127891009=:3203
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="p4p800-hpet-enable-hack.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.HPX.4.33n.0509280903290.3203@studcom.urz.uni-halle.de>
Content-Description: 
Content-Disposition: attachment; filename="p4p800-hpet-enable-hack.diff"

SW5kZXg6IGxpbnV4LTIuNi4xMy9hcmNoL2kzODYva2VybmVsL2FjcGkvYm9v
dC5jDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0gbGludXgtMi42LjEz
Lm9yaWcvYXJjaC9pMzg2L2tlcm5lbC9hY3BpL2Jvb3QuYwkyMDA1LTA4LTMw
IDE5OjIxOjAwLjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4LTIuNi4xMy9h
cmNoL2kzODYva2VybmVsL2FjcGkvYm9vdC5jCTIwMDUtMDktMjcgMjE6MTg6
MDMuMDAwMDAwMDAwICswMjAwDQpAQCAtNTkxLDYgKzU5MSw3IEBAIHN0YXRp
YyBpbnQgX19pbml0IGFjcGlfcGFyc2Vfc2JmKHVuc2lnbmUNCiANCiAjaWZk
ZWYgQ09ORklHX0hQRVRfVElNRVINCiANCisjaWYgMA0KIHN0YXRpYyBpbnQg
X19pbml0IGFjcGlfcGFyc2VfaHBldCh1bnNpZ25lZCBsb25nIHBoeXMsIHVu
c2lnbmVkIGxvbmcgc2l6ZSkNCiB7DQogCXN0cnVjdCBhY3BpX3RhYmxlX2hw
ZXQgKmhwZXRfdGJsOw0KQEAgLTYyOCw4ICs2MjksNDEgQEAgc3RhdGljIGlu
dCBfX2luaXQgYWNwaV9wYXJzZV9ocGV0KHVuc2lnbg0KIA0KIAlyZXR1cm4g
MDsNCiB9DQorI2VuZGlmDQorDQorc3RhdGljIHUzMiBfX2luaXQgcmVhZF9w
Y2lfY29uZmlnXzMyKHUzMiBhZGRyZXNzKQ0KK3sNCisJb3V0bChhZGRyZXNz
LCAweGNmOCk7DQorCXJldHVybiBpbmwoMHhjZmMpOw0KK30NCisNCitzdGF0
aWMgdm9pZCBfX2luaXQgd3JpdGVfcGNpX2NvbmZpZ18zMih1MzIgYWRkcmVz
cywgdTMyIHZhbHVlKQ0KK3sNCisJb3V0bChhZGRyZXNzLCAweGNmOCk7DQor
CW91dGwodmFsdWUsIDB4Y2ZjKTsNCit9DQorDQorI2RlZmluZSBQQ0lBRERS
KGJ1cywgZGV2LCBmbiwgcmVnKSAoMHg4MDAwMDAwMCB8IChidXMgPDwgMTYp
IHwgKGRldiA8PCAxMSkgfCAoZm4gPDwgOCkgfCByZWcpDQorDQorc3RhdGlj
IHZvaWQgX19pbml0IGhhY2tfaHBldCh2b2lkKQ0KK3sNCisJZXh0ZXJuIHVu
c2lnbmVkIGxvbmcgaHBldF9hZGRyZXNzOw0KKwl2b2lkIF9faW9tZW0gKmhw
ZXQ7DQorDQorCXUzMiBjZmcgPSByZWFkX3BjaV9jb25maWdfMzIoUENJQURE
UigwLCAzMSwgMCwgMHhkMCkpOw0KKwljZmcgJj0gfjB4MDAwMTgwMDA7IC8q
IHNldCBhZGRyZXNzICovDQorCWNmZyB8PSAweDAwMDIwMDAwOyAvKiBlbmFi
bGUgKi8NCisJd3JpdGVfcGNpX2NvbmZpZ18zMihQQ0lBRERSKDAsIDMxLCAw
LCAweGQwKSwgY2ZnKTsNCisNCisJaHBldCA9IF9fYWNwaV9tYXBfdGFibGUo
MHhmZWQwMDAwMCwgMHg0MDApOw0KKwl3cml0ZWwoMHgwMDAwMDAwMiwgaHBl
dCArIDB4MTApOyAvKiBsZWdhY3kgcm91dGluZyAqLw0KKwl3cml0ZWwoMHgw
MDAwMTYwMCwgaHBldCArIDB4MTQwKTsgLyogdGltZXIgMjogaW50ZXJydXB0
IDExICovDQorCWhwZXRfYWRkcmVzcyA9IDB4ZmVkMDAwMDA7DQorCXByaW50
ayhLRVJOX0lORk8gUFJFRklYICJIUEVUIGhhY2sgZW5hYmxlZCwgYmFzZTog
JSNseFxuIiwgaHBldF9hZGRyZXNzKTsNCit9DQogI2Vsc2UNCiAjZGVmaW5l
CWFjcGlfcGFyc2VfaHBldAlOVUxMDQorI2RlZmluZSBoYWNrX2hwZXQoKQ0K
ICNlbmRpZg0KIA0KICNpZmRlZiBDT05GSUdfWDg2X1BNX1RJTUVSDQpAQCAt
MTE2NCw3ICsxMTk4LDcgQEAgaW50IF9faW5pdCBhY3BpX2Jvb3RfaW5pdCh2
b2lkKQ0KIAkgKi8NCiAJYWNwaV9wcm9jZXNzX21hZHQoKTsNCiANCi0JYWNw
aV90YWJsZV9wYXJzZShBQ1BJX0hQRVQsIGFjcGlfcGFyc2VfaHBldCk7DQor
CWhhY2tfaHBldCgpOw0KIA0KIAlyZXR1cm4gMDsNCiB9DQo=
--2015913978-1804928587-1127891009=:3203--
