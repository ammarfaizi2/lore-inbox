Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVLUU7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVLUU7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVLUU7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:59:06 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:39867 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751203AbVLUU7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:59:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=hGzVd3Lhfc+DyGF1UqTCcvIpM5C6sVQspbx+31x6JvsvHbKeaGsk4aLJ05kcXpm51PxPkNxbmV64P64axAChhGwH9oXe/62y5ZBPBN1Z5xQSr3UMudZY0zV10iFPm9/ftuRkRnfyzd2B1w4xDiBUcEBWDfP5YWzUqD02cdgOmpk=
Message-ID: <d120d5000512211259w135b1161l6960fef6e840b983@mail.gmail.com>
Date: Wed, 21 Dec 2005 15:59:02 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Mouse stalls with 2.6.5-rc5-mm2
Cc: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <9a8748490512111149l358f18abuc7f0685413f75c06@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_32594_24573983.1135198742345"
References: <9a8748490512110548h22889559ld81374f2626c3ed2@mail.gmail.com>
	 <200512111327.40578.dtor_core@ameritech.net>
	 <9a8748490512111149l358f18abuc7f0685413f75c06@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_32594_24573983.1135198742345
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 12/11/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 12/11/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> > To stop resync attempts do:
> >
> >         echo -n 0 > /sys/bus/serio/devices/serioX/resync_time
> >
> > where serioX is serio port asociated with your mouse.
> >
> This cures the problem nicely with no obvious ill effects with the
> mouse plugged into the KVM...
>

Jesper,

Could you please try applying the attached patch to -mm and see if you
still have "resync failed" messages when you don't "echo 0" into
resync_time attribute?

Thank you in advance,

Dmitry

------=_Part_32594_24573983.1135198742345
Content-Type: application/octet-stream; name="psmouse-resync-update.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="psmouse-resync-update.patch"

IGRyaXZlcnMvaW5wdXQvbW91c2UvcHNtb3VzZS1iYXNlLmMgfCAgIDE3ICsrKysrKysrKysrKysr
KysrCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQoKSW5kZXg6IGxpbnV4L2RyaXZl
cnMvaW5wdXQvbW91c2UvcHNtb3VzZS1iYXNlLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgub3JpZy9k
cml2ZXJzL2lucHV0L21vdXNlL3BzbW91c2UtYmFzZS5jCisrKyBsaW51eC9kcml2ZXJzL2lucHV0
L21vdXNlL3BzbW91c2UtYmFzZS5jCkBAIC0xMDI5LDYgKzEwMjksMjMgQEAgc3RhdGljIGludCBw
c21vdXNlX3N3aXRjaF9wcm90b2NvbChzdHJ1YwogCWVsc2UKIAkJcHNtb3VzZS0+dHlwZSA9IHBz
bW91c2VfZXh0ZW5zaW9ucyhwc21vdXNlLCBwc21vdXNlX21heF9wcm90bywgMSk7CiAKKwkvKgor
CSAqIElmIG1vdXNlJ3MgcGFja2V0IHNpemUgaXMgMyB0aGVyZSBpcyBubyBwb2ludCBpbiBwb2xs
aW5nIHRoZQorCSAqIGRldmljZSBpbiBob3BlcyB0byBkZXRlY3QgcHJvdG9jb2wgcmVzZXQgLSB3
ZSB3b24ndCBnZXQgbGVzcworCSAqIHRoYW4gMyBieXRlcyByZXNwb25zZSBhbnlob3cuCisJICov
CisJaWYgKHBzbW91c2UtPnBrdHNpemUgPT0gMykKKwkJcHNtb3VzZS0+cmVzeW5jX3RpbWUgPSAw
OworCisJLyoKKwkgKiBTb21lIHNtYXJ0IEtWTXMgZmFrZSByZXNwb25zZSB0byBQT0xMIGNvbW1h
bmQgcmV0dXJuaW5nIGp1c3QKKwkgKiAzIGJ5dGVzIGFuZCBtZXNzaW5nIHVwIG91ciByZXN5bmMg
bG9naWMsIHNvIGlmIGluaXRpYWwgcG9sbAorCSAqIGZhaWxzIHdlIHdvbid0IHRyeSBwb2xsaW5n
IHRoZSBkZXZpY2UgYW55bW9yZS4gSG9wZWZ1bGx5CisJICogc3VjaCBLVk0gd2lsbCBtYWludGFp
biBpbml0aWFsbHkgc2VsZWN0ZWQgcHJvdG9jb2wuCisJICovCisJaWYgKHBzbW91c2UtPnJlc3lu
Y190aW1lICYmIHBzbW91c2UtPnBvbGwocHNtb3VzZSkpCisJCXBzbW91c2UtPnJlc3luY190aW1l
ID0gMDsKKwogCXNwcmludGYocHNtb3VzZS0+ZGV2bmFtZSwgIiVzICVzICVzIiwKIAkJcHNtb3Vz
ZV9wcm90b2NvbF9ieV90eXBlKHBzbW91c2UtPnR5cGUpLT5uYW1lLCBwc21vdXNlLT52ZW5kb3Is
IHBzbW91c2UtPm5hbWUpOwogCg==
------=_Part_32594_24573983.1135198742345--
