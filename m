Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTFDH4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 03:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTFDH4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 03:56:14 -0400
Received: from pop.gmx.de ([213.165.64.20]:3804 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263129AbTFDH4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 03:56:12 -0400
Message-Id: <5.2.0.9.2.20030604100227.00cd2020@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 04 Jun 2003 10:14:02 +0200
To: Tom Sightler <ttsig@tuxyturvy.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk
  trees.
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjanv@redhat.com>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1054582030.4679.15.camel@iso-8590-lx.zeusinc.com>
References: <Pine.LNX.4.44.0306021927170.10228-100000@localhost.localdomain>
 <Pine.LNX.4.44.0306021927170.10228-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_11308296==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_11308296==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 03:27 PM 6/2/2003 -0400, Tom Sightler wrote:
>On Mon, 2003-06-02 at 13:28, Ingo Molnar wrote:
> > to prove this point, could you try and renice wineserver to -10 (as root)
> > - does that fix the latency issues still?
> >
> > (if this doesnt then it could be the foreground process starving yet
> > another process - we have to find out which one.)
>
>Yes, I thought the same thing, and I did just that, but no, it doesn't
>fix the latency issue.  This system has very little running, I made sure
>that there were no sound servers such as esd or arts running, nothing.
>Basically, a plain KDE (with artsd disabled), mozilla, and Crossover
>wine plugin.  Even though I couldn't see how it would affect anything I
>tried bumping up the priorities of other processes such as mozilla
>itself, X, etc.  Nothing fixed the problem except for lowering the
>priority of the wine process.

Feel like trying something else for grins?  If it's thud.c type starvation 
you're seeing, the attached club should beat it into submission.

         -Mike 
--=====================_11308296==_
Content-Type: application/octet-stream; name="xx.diff";
 x-mac-type="42494E41"; x-mac-creator="5843454C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xx.diff"

LS0tIGxpbnV4LTIuNS43MC52aXJnaW4va2VybmVsL3NjaGVkLmMub3JnCVR1ZSBKdW4gIDMgMDY6
NDQ6NDggMjAwMworKysgbGludXgtMi41LjcwLnZpcmdpbi9rZXJuZWwvc2NoZWQuYwlUdWUgSnVu
ICAzIDE3OjI4OjEwIDIwMDMKQEAgLTY2LDcgKzY2LDcgQEAKICAqLwogI2RlZmluZSBNSU5fVElN
RVNMSUNFCQkoIDEwICogSFogLyAxMDAwKQogI2RlZmluZSBNQVhfVElNRVNMSUNFCQkoMjAwICog
SFogLyAxMDAwKQotI2RlZmluZSBDSElMRF9QRU5BTFRZCQk1MAorI2RlZmluZSBDSElMRF9QRU5B
TFRZCQk4MAogI2RlZmluZSBQQVJFTlRfUEVOQUxUWQkJMTAwCiAjZGVmaW5lIEVYSVRfV0VJR0hU
CQkzCiAjZGVmaW5lIFBSSU9fQk9OVVNfUkFUSU8JMjUKQEAgLTM1NSw2ICszNTUsNyBAQAogCQkg
KiBzcGVuZHMgc2xlZXBpbmcsIHRoZSBoaWdoZXIgdGhlIGF2ZXJhZ2UgZ2V0cyAtIGFuZCB0aGUK
IAkJICogaGlnaGVyIHRoZSBwcmlvcml0eSBib29zdCBnZXRzIGFzIHdlbGwuCiAJCSAqLworCQlz
bGVlcF90aW1lID0gbWluKHNsZWVwX3RpbWUsIChsb25nKSBwLT50aW1lX3NsaWNlKTsKIAkJc2xl
ZXBfYXZnID0gcC0+c2xlZXBfYXZnICsgc2xlZXBfdGltZTsKIAogCQkvKgpAQCAtNTQ1LDggKzU0
NiwxMCBAQAogCSAqIGFuZCBjaGlsZHJlbiBhcyB3ZWxsLCB0byBrZWVwIG1heC1pbnRlcmFjdGl2
ZSB0YXNrcwogCSAqIGZyb20gZm9ya2luZyB0YXNrcyB0aGF0IGFyZSBtYXgtaW50ZXJhY3RpdmUu
CiAJICovCi0JY3VycmVudC0+c2xlZXBfYXZnID0gY3VycmVudC0+c2xlZXBfYXZnICogUEFSRU5U
X1BFTkFMVFkgLyAxMDA7Ci0JcC0+c2xlZXBfYXZnID0gcC0+c2xlZXBfYXZnICogQ0hJTERfUEVO
QUxUWSAvIDEwMDsKKwlpZiAobGlrZWx5KGN1cnJlbnQtPnBhcmVudC0+cGlkID4gMSkpIHsKKwkJ
Y3VycmVudC0+c2xlZXBfYXZnID0gY3VycmVudC0+c2xlZXBfYXZnICogUEFSRU5UX1BFTkFMVFkg
LyAxMDA7CisJCXAtPnNsZWVwX2F2ZyA9IHAtPnNsZWVwX2F2ZyAqIENISUxEX1BFTkFMVFkgLyAx
MDA7CisJfSBlbHNlIGN1cnJlbnQtPnNsZWVwX2F2ZyA9IHAtPnNsZWVwX2F2ZyA9IE1BWF9TTEVF
UF9BVkc7CiAJcC0+cHJpbyA9IGVmZmVjdGl2ZV9wcmlvKHApOwogCXNldF90YXNrX2NwdShwLCBz
bXBfcHJvY2Vzc29yX2lkKCkpOwogCg==
--=====================_11308296==_--

