Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTEKKc1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTEKKcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:32:20 -0400
Received: from WARSL401PIP5.highway.telekom.at ([195.3.96.90]:544 "HELO
	email04.aon.at") by vger.kernel.org with SMTP id S261294AbTEKK13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:27:29 -0400
Message-ID: <3EBE2895.1C7C89B9@net4you.at>
Date: Sun, 11 May 2003 12:40:21 +0200
From: Wolfgang Scherr <scherr@net4you.at>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mjpeg-developer@lists.sourceforge.net
CC: support@suse.de
Subject: SAA7110 VCR bug (kernel 2.4.x and older)
References: <E18WuHZ-0002gL-00@config17.schlund.de> <200302221941.53088.christian@celindir.de> <3E6114D1.CC45BECE@net4you.at> <200305042250.30861.christian@celindir.de>
Content-Type: multipart/mixed;
 boundary="------------079E91D75DDE4C76A70E113E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------079E91D75DDE4C76A70E113E
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello all,

there is a problem in the SAA7110 driver in the 2.4.x releases (seen
with 2.4.19,2.4.20 in combination with DC10) regarding the VCR-Mode. As
I don't know who is maintaining the v4l stuff currently, I hope the
recipient list is sufficient. Otherwise I apologize for the
inconvinience and would like to ask to forward the problem to the
maintainer....

Problem: With some video source (camcorders, VCRs, ...), it might happen
that the grabber card gets out of sync (result is an instable picture on
the screen due to weak sync quality of the signal).

This problem was reported by several users.

Solution: Switching on the VCR mode of the SAA7110 video frontend
improves frame synchronisation. Simple patch (successfully tested)
added, no other impact on functionality noted. Optionally this bit could
be set/cleared by a module parameter - especially in future releases,
should be trivial - a patch can be provided by me if needed.

Such a functionality may be also available with other video codec
hardware and should be checked/implemented there accordingly.

Best regards,

Wolfgang


[Re: DC 10+ Verwackeltes Bild bei VHS]
Christian von Eichel-Streiber wrote:
> =

> Hallo Wolfgang,
> =

> leider muss ich Dich schon wieder "nerven".
> =

> Ich hatte gehofft, dass mit einer neuen Suse nicht alte Probleme wieder=

> auftreten w=FCrden. Jetzt habe ich die aktuelle SuSE 8.2 und der Zoran =
treiber
> ist schlechter als vorher.
> =

> Leider kann ich aber auch dne Patch, den Du mir das letzte mal gesendet=
 hast
> nicht einsetzen, da sich der Kernel dann beschwert, dass das Ding f=FCr=
 den
> 2.4.19 kompiliert w=E4re unbd jetzt ist ja der 2.4.20 drauf.
> =

> Was kann ich machen, umm wieder an die gepatchte Version zu kommen?
> Auf der Suse-Seite habe ich keinen Hinweis zu einer Fehlerbereinigten V=
ersion
> gefunden.
> =

> Es w=E4re super nett, wenn Du mir noch mal helfen k=F6nntest.
> =

> Vielen Dank
> =

> Christian von Eichel-Streiber
--------------079E91D75DDE4C76A70E113E
Content-Type: application/octet-stream;
 name="saa7110.c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="saa7110.c.patch"

MTY3YzE2Nwo8IAkJc2FhNzExMF93cml0ZShkZWNvZGVyLDB4MEQsMHg4Nik7Ci0tLQo+IAkJ
c2FhNzExMF93cml0ZShkZWNvZGVyLDB4MEQsMHgwNik7CjE3NGMxNzQKPCAJc2FhNzExMF93
cml0ZShkZWNvZGVyLDB4MEQsMHg4Nik7Ci0tLQo+IAlzYWE3MTEwX3dyaXRlKGRlY29kZXIs
MHgwRCwweDA2KTsKMTgzYzE4Mwo8IAkJc2FhNzExMF93cml0ZShkZWNvZGVyLDB4MEQsMHg4
Nyk7Ci0tLQo+IAkJc2FhNzExMF93cml0ZShkZWNvZGVyLDB4MEQsMHgwNyk7CjE5NWMxOTUK
PCAJCTB4RjgsIDB4RjgsIDB4NjAsIDB4NjAsIDB4MDAsIDB4ODYsIDB4MTgsIDB4OTAsCi0t
LQo+IAkJMHhGOCwgMHhGOCwgMHg2MCwgMHg2MCwgMHgwMCwgMHgwNiwgMHgxOCwgMHg5MCwK
MjI5LDIzMGMyMjksMjMwCjwgCQlwcmludGsoS0VSTl9JTkZPICIlc19hdHRhY2g6IGNoaXAg
dmVyc2lvbiAleCwgVkNSIG1vZGVcbiIsIGRldmljZS0+bmFtZSwgc2FhNzExMF9yZWFkKGRl
Y29kZXIpKTsKPCAJCXNhYTcxMTBfd3JpdGUoZGVjb2RlciwweDBELDB4ODYpOwotLS0KPiAJ
CURFQlVHKHByaW50ayhLRVJOX0lORk8gIiVzX2F0dGFjaDogY2hpcCB2ZXJzaW9uICV4XG4i
LCBkZXZpY2UtPm5hbWUsIHNhYTcxMTBfcmVhZChkZWNvZGVyKSkpOwo+IAkJc2FhNzExMF93
cml0ZShkZWNvZGVyLDB4MEQsMHgwNik7CjMwN2MzMDcKPCAJCQkJc2FhNzExMF93cml0ZShk
ZWNvZGVyLCAweDBELCAweDg2KTsKLS0tCj4gCQkJCXNhYTcxMTBfd3JpdGUoZGVjb2Rlciwg
MHgwRCwgMHgwNik7CjMxM2MzMTMKPCAJCQkJc2FhNzExMF93cml0ZShkZWNvZGVyLCAweDBE
LCAweDg2KTsKLS0tCj4gCQkJCXNhYTcxMTBfd3JpdGUoZGVjb2RlciwgMHgwRCwgMHgwNik7
CjMxOGMzMTgKPCAJCQkJc2FhNzExMF93cml0ZShkZWNvZGVyLCAweDBELCAweDg3KTsKLS0t
Cj4gCQkJCXNhYTcxMTBfd3JpdGUoZGVjb2RlciwgMHgwRCwgMHgwNyk7Cg==
--------------079E91D75DDE4C76A70E113E--

