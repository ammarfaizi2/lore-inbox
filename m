Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbUJXOAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbUJXOAx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 10:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbUJXOAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 10:00:53 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:4545 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S261490AbUJXN7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:59:44 -0400
Subject: Re: [PATCH 2.6.9-bk7] Select cpio_list or source directory for
	initramfs image updates [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041024030844.18f2fedd.akpm@osdl.org>
References: <200410200849.i9K8n5921516@mail.osdl.org>
	 <1098533188.668.9.camel@nosferatu.lan>
	 <20041024030844.18f2fedd.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-h7O704s2Lx6ZDL4koXZt"
Date: Sun, 24 Oct 2004 15:59:22 +0200
Message-Id: <1098626362.12420.3.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h7O704s2Lx6ZDL4koXZt
Content-Type: multipart/mixed; boundary="=-o6YOPtySQSU9Fk1/PwrG"


--=-o6YOPtySQSU9Fk1/PwrG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-10-24 at 03:08 -0700, Andrew Morton wrote:
> "Martin Schlemmer [c]" <azarah@nosferatu.za.org> wrote:
> >
> > Here is some updates after talking to Sam Ravnborg.  He did not yet com=
e
> >  back to me, I am not sure if I understood 100% what he meant, but hope=
fully
> >  somebody else will be so kind as to comment.
> >=20
> >  Here is a shortish changelog:
> >=20
> >  - Fix an issue reported by Esben Nielsen <simlo@phys.au.dk> (with
> >  suggestion from Sam Ravnborg).  Build failed if $O (output dir) was
> >  set.  This is done by pre-pending $srctree if the shipped list is
> >  referenced.
> >=20
> >  - Also fix calling of gen_initramfs_list.sh if $O (output dir) is set
> >  by pre-pending $srctree.
> >=20
> >  - I also moved initramfs_list to initramfs_list.shipped, to make sure =
we
> >  always have an 'fall back' list (say you unset CONFIG_INITRAMFS_SOURCE
> >  and deleted your custom intramfs source directory, then building will =
not
> >  fail).
> >=20
> >  - Kbuild style cleanups.
> >=20
> >  - Improved error checking.  For example gen_initramfs_list.sh will
> >  output a simple list if the target directory is empty, and we verify
> >  that the shipped initramfs_list is present before touching it.
> >=20
> >  - Only update the temp initramfs_list if the source list/directory hav=
e
> >  changed.
> >=20
> >  - Cleanup temporary initramfs_list when 'make clean' or 'make mrproper=
'
> >  is called.
> >=20
> >=20
> >  This patch should apply to both 2.6.9-bk7 and 2.6.9-mm1.
>=20
> hmm.  You have a patch in the email body and two slightly different patch=
es
> as attachments.  All bases covered ;)
>=20
> I'll stick
> "select-cpio_list-or-source-directory-for-initramfs-image-v7.patch" into
> -mm but would prefer that this patch come in via Sam's tree please.
>=20

No comment =3D)  v7 should be fine, but it have one typo that wont affect
anything, so here is v8.  I have tested with O=3D set, and all fail
conditions I could think of, and it seems all right.


Thanks,

--=20
Martin Schlemmer


--=-o6YOPtySQSU9Fk1/PwrG
Content-Disposition: attachment;
	filename*0=select-cpio_list-or-source-directory-for-initramfs-image-v8.p;
	filename*1=atch
Content-Type: text/x-patch;
	name=select-cpio_list-or-source-directory-for-initramfs-image-v8.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: base64

ZGlmZiAtdXByTiAtWCBkb250ZGlmZiBsaW51eC0yLjYuOS1iazcub3JpZy9zY3JpcHRzL2dlbl9p
bml0cmFtZnNfbGlzdC5zaCBsaW51eC0yLjYuOS1iazcvc2NyaXB0cy9nZW5faW5pdHJhbWZzX2xp
c3Quc2gNCi0tLSBsaW51eC0yLjYuOS1iazcub3JpZy9zY3JpcHRzL2dlbl9pbml0cmFtZnNfbGlz
dC5zaAkyMDA0LTEwLTIzIDExOjIzOjQ5LjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4LTIuNi45
LWJrNy9zY3JpcHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaAkyMDA0LTEwLTIzIDExOjI2OjUyLjAw
MDAwMDAwMCArMDIwMA0KQEAgLTc2LDkgKzc2LDIzIEBAIHBhcnNlKCkgew0KIAlyZXR1cm4gMA0K
IH0NCiANCi1maW5kICIke3NyY2Rpcn0iIC1wcmludGYgIiVwICVtICVVICVHXG4iIHwgXA0KLXdo
aWxlIHJlYWQgeDsgZG8NCi0JcGFyc2UgJHt4fQ0KLWRvbmUNCitkaXJsaXN0PSQoZmluZCAiJHtz
cmNkaXJ9IiAtcHJpbnRmICIlcCAlbSAlVSAlR1xuIiAyPi9kZXYvbnVsbCkNCisNCisjIElmICRk
aXJsaXN0IGlzIG9ubHkgb25lIGxpbmUsIHRoZW4gdGhlIGRpcmVjdG9yeSBpcyBlbXB0eQ0KK2lm
IFsgICIkKGVjaG8gIiR7ZGlybGlzdH0iIHwgd2MgLWwpIiAtZ3QgMSBdOyB0aGVuDQorCWVjaG8g
IiR7ZGlybGlzdH0iIHwgXA0KKwl3aGlsZSByZWFkIHg7IGRvDQorCQlwYXJzZSAke3h9DQorCWRv
bmUNCitlbHNlDQorCSMgRmFpbHNhZmUgaW4gY2FzZSBkaXJlY3RvcnkgaXMgZW1wdHkNCisJY2F0
IDw8LUVPRg0KKwkJIyBUaGlzIGlzIGEgdmVyeSBzaW1wbGUgaW5pdHJhbWZzDQorDQorCQlkaXIg
L2RldiAwNzU1IDAgMA0KKwkJbm9kIC9kZXYvY29uc29sZSAwNjAwIDAgMCBjIDUgMQ0KKwkJZGly
IC9yb290IDA3MDAgMCAwDQorCUVPRg0KK2ZpDQogDQogZXhpdCAwDQpkaWZmIC11cHJOIC1YIGRv
bnRkaWZmIGxpbnV4LTIuNi45LWJrNy5vcmlnL3Vzci9NYWtlZmlsZSBsaW51eC0yLjYuOS1iazcv
dXNyL01ha2VmaWxlDQotLS0gbGludXgtMi42LjktYms3Lm9yaWcvdXNyL01ha2VmaWxlCTIwMDQt
MTAtMjMgMTE6MjM6NTQuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi42LjktYms3L3Vzci9N
YWtlZmlsZQkyMDA0LTEwLTIzIDEzOjU2OjI4LjY5MTUwODgyNCArMDIwMA0KQEAgLTYsOSArNiwx
MSBAQCBob3N0cHJvZ3MteSAgOj0gZ2VuX2luaXRfY3Bpbw0KIGNsZWFuLWZpbGVzIDo9IGluaXRy
YW1mc19kYXRhLmNwaW8uZ3oNCiANCiAjIElmIHlvdSB3YW50IGEgZGlmZmVyZW50IGxpc3Qgb2Yg
ZmlsZXMgaW4gdGhlIGluaXRyYW1mc19kYXRhLmNwaW8NCi0jIHRoZW4geW91IGNhbiBlaXRoZXIg
b3ZlcndyaXRlIHRoZSBjcGlvX2xpc3QgaW4gdGhpcyBkaXJlY3RvcnkNCi0jIG9yIHNldCBJTklU
UkFNRlNfTElTVCB0byBhbm90aGVyIGZpbGVuYW1lLg0KLUlOSVRSQU1GU19MSVNUIDo9ICQob2Jq
KS9pbml0cmFtZnNfbGlzdA0KKyMgdGhlbiB5b3UgY2FuIGVpdGhlciBvdmVyd3JpdGUgaW5pdHJh
bWZzX2xpc3Quc2hpcHBlZCBpbiB0aGlzIGRpcmVjdG9yeQ0KKyMgb3Igc2V0IENPTkZJR19JTklU
UkFNRlNfU09VUkNFIHRvIGFub3RoZXIgZmlsZW5hbWUgb3IgZGlyZWN0b3J5Lg0KK2luaXRyYW1m
c19saXN0IDo9IGluaXRyYW1mc19saXN0DQorDQorY2xlYW4tZmlsZXMgKz0gJChpbml0cmFtZnNf
bGlzdCkNCiANCiAjIGluaXRyYW1mc19kYXRhLm8gY29udGFpbnMgdGhlIGluaXRyYW1mc19kYXRh
LmNwaW8uZ3ogaW1hZ2UuDQogIyBUaGUgaW1hZ2UgaXMgaW5jbHVkZWQgdXNpbmcgLmluY2Jpbiwg
YSBkZXBlbmRlbmN5IHdoaWNoIGlzIG5vdA0KQEAgLTIzLDI4ICsyNSw3NSBAQCAkKG9iaikvaW5p
dHJhbWZzX2RhdGEubzogJChvYmopL2luaXRyYW1mDQogIyBDb21tZW50ZWQgb3V0IGZvciBub3cN
CiAjIGluaXRyYW1mcy15IDo9ICQob2JqKS9yb290L2hlbGxvDQogDQotcXVpZXRfY21kX2dlbl9s
aXN0ID0gR0VOX0lOSVRSQU1GU19MSVNUICRADQorIyBSZXR1cm5zOg0KKyMgICB2YWxpZCBjb21t
YW5kIGlmIGV2ZXJ5dGhpbmcgc2hvdWxkIGJlIGZpbmUNCisjICAgJ3VwdG9kYXRlJyBpZiBub3Ro
aW5nIG5lZWRzIHRvIGJlIGRvbmUNCisjICAgJ21pc3NpbmcnIGlmICQoc3JjdHJlZSkvJChzcmMp
LyQoaW5pdHJhbWZzX2xpc3QpLnNoaXBwZWQgaXMgbWlzc2luZw0KK3F1aWV0X2NtZF9nZW5fbGlz
dCA9IEdFTiAgICAgJEANCiAgICAgICBjbWRfZ2VuX2xpc3QgPSAkKHNoZWxsIFwNCi0gICAgICAg
IGlmIHRlc3QgLWYgJChDT05GSUdfSU5JVFJBTUZTX1NPVVJDRSk7IHRoZW4gXA0KLQkgIGlmIFsg
JChDT05GSUdfSU5JVFJBTUZTX1NPVVJDRSkgIT0gJEAgXTsgdGhlbiBcDQotCSAgICBlY2hvICdj
cCAtZiAkKENPTkZJR19JTklUUkFNRlNfU09VUkNFKSAkQCc7IFwNCisJaWYgWyAtZCAkKENPTkZJ
R19JTklUUkFNRlNfU09VUkNFKSBdOyBcDQorCXRoZW4gXA0KKwkgIGlmIFsgISAtZiAiJChvYmop
LyQoaW5pdHJhbWZzX2xpc3QpIiAtbyBcDQorCSAgICAgICAieGBmaW5kICQoQ09ORklHX0lOSVRS
QU1GU19TT1VSQ0UpIC1uZXdlciAiJChvYmopLyQoaW5pdHJhbWZzX2xpc3QpIiAyPi9kZXYvbnVs
bGAiICE9ICJ4IiBdOyBcDQorCSAgdGhlbiBcDQorCSAgICBlY2hvICckKENPTkZJR19TSEVMTCkg
JChzcmN0cmVlKS9zY3JpcHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaCBcDQorCSAgICAgICQoQ09O
RklHX0lOSVRSQU1GU19TT1VSQ0UpID4gIiQob2JqKS8kKGluaXRyYW1mc19saXN0KSInOyBcDQog
CSAgZWxzZSBcDQotCSAgICBlY2hvICdlY2hvIFVzaW5nIHNoaXBwZWQgJEAnOyBcDQotCSAgZmk7
IFwNCi0JZWxpZiB0ZXN0IC1kICQoQ09ORklHX0lOSVRSQU1GU19TT1VSQ0UpOyB0aGVuIFwNCi0J
ICBlY2hvICdzY3JpcHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaCAkKENPTkZJR19JTklUUkFNRlNf
U09VUkNFKSA+ICRAJzsgXA0KKwkgICAgZWNobyAndXB0b2RhdGUnOyBcDQorCSAgZmkgXA0KIAll
bHNlIFwNCi0JICBlY2hvICdlY2hvIFVzaW5nIHNoaXBwZWQgJEAnOyBcDQorCSAgaWYgWyAtZiAk
KENPTkZJR19JTklUUkFNRlNfU09VUkNFKSAtYSBcDQorCSAgICAgICAkKENPTkZJR19JTklUUkFN
RlNfU09VUkNFKSAhPSAiJChvYmopLyQoaW5pdHJhbWZzX2xpc3QpIiBdOyBcDQorCSAgdGhlbiBc
DQorCSAgICBpZiBbICEgLWYgIiQob2JqKS8kKGluaXRyYW1mc19saXN0KSIgLW8gXA0KKwkgICAg
ICAgICAkKENPTkZJR19JTklUUkFNRlNfU09VUkNFKSAtbnQgIiQob2JqKS8kKGluaXRyYW1mc19s
aXN0KSIgXTsgXA0KKwkgICAgdGhlbiBcDQorCSAgICAgIGVjaG8gJ2NwIC1mICQoQ09ORklHX0lO
SVRSQU1GU19TT1VSQ0UpICIkKG9iaikvJChpbml0cmFtZnNfbGlzdCkiJzsgXA0KKwkgICAgZWxz
ZSBcDQorCSAgICAgIGVjaG8gJ3VwdG9kYXRlJzsgXA0KKwkgICAgZmkgXA0KKwkgIGVsc2UgXA0K
KwkgICAgaWYgWyAtZiAiJChzcmN0cmVlKS8kKHNyYykvJChpbml0cmFtZnNfbGlzdCkuc2hpcHBl
ZCIgXTsgXA0KKwkgICAgdGhlbiBcDQorCSAgICAgIGlmIFsgISAtZiAiJChvYmopLyQoaW5pdHJh
bWZzX2xpc3QpIiAtbyBcDQorCSAgICAgICAgICAgIiQoc3JjdHJlZSkvJChzcmMpLyQoaW5pdHJh
bWZzX2xpc3QpLnNoaXBwZWQiIC1udCAiJChvYmopLyQoaW5pdHJhbWZzX2xpc3QpIiBdOyBcDQor
CSAgICAgIHRoZW4gXA0KKwkgICAgICAgIGVjaG8gJ2NwIC1mICIkKHNyY3RyZWUpLyQoc3JjKS8k
KGluaXRyYW1mc19saXN0KS5zaGlwcGVkIiBcDQorCSAgICAgICAgICAiJChvYmopLyQoaW5pdHJh
bWZzX2xpc3QpIic7IFwNCisJICAgICAgZWxzZSBcDQorCSAgICAgICAgZWNobyAndXB0b2RhdGUn
OyBcDQorCSAgICAgIGZpIFwNCisJICAgIGVsc2UgXA0KKwkgICAgICBlY2hvICdtaXNzaW5nJzsg
XA0KKwkgICAgZmkgXA0KKwkgIGZpIFwNCiAJZmkpDQogDQotDQotJChJTklUUkFNRlNfTElTVCk6
IEZPUkNFDQotCSQoY2FsbCBjbWQsZ2VuX2xpc3QpDQoraW5pdHJhbWZzX2xpc3Rfc3RhdGVfdXB0
b2RhdGUgOj0NCitpbml0cmFtZnNfbGlzdF9zdGF0ZV9vdXRvZmRhdGUgOj0NCitpbml0cmFtZnNf
bGlzdF9zdGF0ZV9taXNzaW5nIDo9DQorDQoraWZlcSAoJChjbWRfZ2VuX2xpc3QpLHVwdG9kYXRl
KQ0KKyAgaW5pdHJhbWZzX2xpc3Rfc3RhdGVfdXB0b2RhdGUgOj0gMQ0KK2Vsc2UNCisgIGlmZXEg
KCQoY21kX2dlbl9saXN0KSxtaXNzaW5nKQ0KKyAgICBpbml0cmFtZnNfbGlzdF9zdGF0ZV9taXNz
aW5nIDo9IDENCisgIGVsc2UNCisgICAgaW5pdHJhbWZzX2xpc3Rfc3RhdGVfb3V0b2ZkYXRlIDo9
IDENCisgIGVuZGlmDQorZW5kaWYNCisNCiskKG9iaikvJChpbml0cmFtZnNfbGlzdCk6IEZPUkNF
DQorCSQoaWYgJChpbml0cmFtZnNfbGlzdF9zdGF0ZV91cHRvZGF0ZSksLCBcDQorCSAgJChpZiAk
KGluaXRyYW1mc19saXN0X3N0YXRlX291dG9mZGF0ZSksICQoY2FsbCBjbWQsZ2VuX2xpc3QpLCBc
DQorCSAgICAkKGlmICQoaW5pdHJhbWZzX2xpc3Rfc3RhdGVfbWlzc2luZyksIFwNCisJICAgICAg
QGVjaG8gJ0ZpbGUgIiQoc3JjKS8kKGluaXRyYW1mc19saXN0KS5zaGlwcGVkIiBkb2VzIG5vdCBl
eGlzdCc7IFwNCisJICAgICAgL2Jpbi9mYWxzZSkpKQ0KIA0KIHF1aWV0X2NtZF9jcGlvID0gQ1BJ
TyAgICAkQA0KLSAgICAgIGNtZF9jcGlvID0gLi8kPCAkKElOSVRSQU1GU19MSVNUKSA+ICRADQor
ICAgICAgY21kX2NwaW8gPSAuLyQ8ICQob2JqKS8kKGluaXRyYW1mc19saXN0KSA+ICRADQogDQot
JChvYmopL2luaXRyYW1mc19kYXRhLmNwaW86ICQob2JqKS9nZW5faW5pdF9jcGlvICQoaW5pdHJh
bWZzLXkpICQoSU5JVFJBTUZTX0xJU1QpIEZPUkNFDQorJChvYmopL2luaXRyYW1mc19kYXRhLmNw
aW86ICQob2JqKS9nZW5faW5pdF9jcGlvICQoaW5pdHJhbWZzLXkpICQob2JqKS8kKGluaXRyYW1m
c19saXN0KSBGT1JDRQ0KIAkkKGNhbGwgaWZfY2hhbmdlZCxjcGlvKQ0KIA0KIHRhcmdldHMgKz0g
aW5pdHJhbWZzX2RhdGEuY3Bpbw0KZGlmZiAtdXByTiAtWCBkb250ZGlmZiBsaW51eC0yLjYuOS1i
azcub3JpZy91c3IvaW5pdHJhbWZzX2xpc3QgbGludXgtMi42LjktYms3L3Vzci9pbml0cmFtZnNf
bGlzdA0KLS0tIGxpbnV4LTIuNi45LWJrNy5vcmlnL3Vzci9pbml0cmFtZnNfbGlzdAkyMDA0LTEw
LTIzIDExOjIzOjU0LjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4LTIuNi45LWJrNy91c3IvaW5p
dHJhbWZzX2xpc3QJMTk3MC0wMS0wMSAwMjowMDowMC4wMDAwMDAwMDAgKzAyMDANCkBAIC0xLDUg
KzAsMCBAQA0KLSMgVGhpcyBpcyBhIHZlcnkgc2ltcGxlIGluaXRyYW1mcyAtIG1vc3RseSBwcmVs
aW1pbmFyeSBmb3IgZnV0dXJlIGV4cGFuc2lvbg0KLQ0KLWRpciAvZGV2IDA3NTUgMCAwDQotbm9k
IC9kZXYvY29uc29sZSAwNjAwIDAgMCBjIDUgMQ0KLWRpciAvcm9vdCAwNzAwIDAgMA0KZGlmZiAt
dXByTiAtWCBkb250ZGlmZiBsaW51eC0yLjYuOS1iazcub3JpZy91c3IvaW5pdHJhbWZzX2xpc3Qu
c2hpcHBlZCBsaW51eC0yLjYuOS1iazcvdXNyL2luaXRyYW1mc19saXN0LnNoaXBwZWQNCi0tLSBs
aW51eC0yLjYuOS1iazcub3JpZy91c3IvaW5pdHJhbWZzX2xpc3Quc2hpcHBlZAkxOTcwLTAxLTAx
IDAyOjAwOjAwLjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4LTIuNi45LWJrNy91c3IvaW5pdHJh
bWZzX2xpc3Quc2hpcHBlZAkyMDA0LTEwLTIzIDExOjI2OjUyLjAwMDAwMDAwMCArMDIwMA0KQEAg
LTAsMCArMSw1IEBADQorIyBUaGlzIGlzIGEgdmVyeSBzaW1wbGUgaW5pdHJhbWZzIC0gbW9zdGx5
IHByZWxpbWluYXJ5IGZvciBmdXR1cmUgZXhwYW5zaW9uDQorDQorZGlyIC9kZXYgMDc1NSAwIDAN
Citub2QgL2Rldi9jb25zb2xlIDA2MDAgMCAwIGMgNSAxDQorZGlyIC9yb290IDA3MDAgMCAwDQo=


--=-o6YOPtySQSU9Fk1/PwrG--

--=-h7O704s2Lx6ZDL4koXZt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBe7U6qburzKaJYLYRAgKWAJ0QYkqefa0M4w5tUC9/wp7d+EI27gCeIVsz
fX14wir4yySP+Z7DB/I8s6Q=
=XTM3
-----END PGP SIGNATURE-----

--=-h7O704s2Lx6ZDL4koXZt--

