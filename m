Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272257AbRIOL33>; Sat, 15 Sep 2001 07:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272242AbRIOL3T>; Sat, 15 Sep 2001 07:29:19 -0400
Received: from [209.10.41.242] ([209.10.41.242]:60824 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S272080AbRIOL3D>;
	Sat, 15 Sep 2001 07:29:03 -0400
Date: Fri, 14 Sep 2001 13:02:14 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, <linux-raid@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [patch] raid-xor-2.4.10-A0
In-Reply-To: <Pine.LNX.4.33.0109141251410.3820-200000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0109141301320.3933-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1277751266-1000465334=:3933"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1277751266-1000465334=:3933
Content-Type: TEXT/PLAIN; charset=US-ASCII


patch mixup - raid-xor-2.4.10-A1 attached, which does the prefetch
enhancements.

	Ingo

--8323328-1277751266-1000465334=:3933
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="raid-xor-2.4.10-A1"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0109141302140.3933@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="raid-xor-2.4.10-A1"

LS0tIGxpbnV4L2luY2x1ZGUvYXNtLWkzODYveG9yLmgub3JpZwlNb24gTm92
IDEzIDA0OjM5OjUxIDIwMDANCisrKyBsaW51eC9pbmNsdWRlL2FzbS1pMzg2
L3hvci5oCUZyaSBTZXAgMTQgMTI6NDU6MzkgMjAwMQ0KQEAgLTU1NSwxOSAr
NTU1LDIwIEBADQogCQk6ICJtZW1vcnkiKQ0KIA0KICNkZWZpbmUgT0ZGUyh4
KQkJIjE2KigiI3giKSINCi0jZGVmaW5lCVBGMCh4KQkJIglwcmVmZXRjaHQw
ICAiT0ZGUyh4KSIoJTEpICAgO1xuIg0KLSNkZWZpbmUgTEQoeCx5KQkJIiAg
ICAgICBtb3ZhcHMgICAiT0ZGUyh4KSIoJTEpLCAlJXhtbSIjeSIgICA7XG4i
DQotI2RlZmluZSBTVCh4LHkpCQkiICAgICAgIG1vdmFwcyAlJXhtbSIjeSIs
ICAgIk9GRlMoeCkiKCUxKSAgIDtcbiINCi0jZGVmaW5lIFBGMSh4KQkJIglw
cmVmZXRjaG50YSAiT0ZGUyh4KSIoJTIpICAgO1xuIg0KLSNkZWZpbmUgUEYy
KHgpCQkiCXByZWZldGNobnRhICJPRkZTKHgpIiglMykgICA7XG4iDQotI2Rl
ZmluZSBQRjMoeCkJCSIJcHJlZmV0Y2hudGEgIk9GRlMoeCkiKCU0KSAgIDtc
biINCi0jZGVmaW5lIFBGNCh4KQkJIglwcmVmZXRjaG50YSAiT0ZGUyh4KSIo
JTUpICAgO1xuIg0KLSNkZWZpbmUgUEY1KHgpCQkiCXByZWZldGNobnRhICJP
RkZTKHgpIiglNikgICA7XG4iDQotI2RlZmluZSBYTzEoeCx5KQkiICAgICAg
IHhvcnBzICAgIk9GRlMoeCkiKCUyKSwgJSV4bW0iI3kiICAgO1xuIg0KLSNk
ZWZpbmUgWE8yKHgseSkJIiAgICAgICB4b3JwcyAgICJPRkZTKHgpIiglMyks
ICUleG1tIiN5IiAgIDtcbiINCi0jZGVmaW5lIFhPMyh4LHkpCSIgICAgICAg
eG9ycHMgICAiT0ZGUyh4KSIoJTQpLCAlJXhtbSIjeSIgICA7XG4iDQotI2Rl
ZmluZSBYTzQoeCx5KQkiICAgICAgIHhvcnBzICAgIk9GRlMoeCkiKCU1KSwg
JSV4bW0iI3kiICAgO1xuIg0KLSNkZWZpbmUgWE81KHgseSkJIiAgICAgICB4
b3JwcyAgICJPRkZTKHgpIiglNiksICUleG1tIiN5IiAgIDtcbiINCisjZGVm
aW5lIFBGX09GRlMoeCkJIjI1NisxNiooIiN4IikiDQorI2RlZmluZQlQRjAo
eCkJCSIJcHJlZmV0Y2hudGEgIlBGX09GRlMoeCkiKCUxKQkJO1xuIg0KKyNk
ZWZpbmUgTEQoeCx5KQkJIiAgICAgICBtb3ZhcHMgICAiT0ZGUyh4KSIoJTEp
LCAlJXhtbSIjeSIJO1xuIg0KKyNkZWZpbmUgU1QoeCx5KQkJIiAgICAgICBt
b3ZhcHMgJSV4bW0iI3kiLCAgICJPRkZTKHgpIiglMSkJO1xuIg0KKyNkZWZp
bmUgUEYxKHgpCQkiCXByZWZldGNobnRhICJQRl9PRkZTKHgpIiglMikJCTtc
biINCisjZGVmaW5lIFBGMih4KQkJIglwcmVmZXRjaG50YSAiUEZfT0ZGUyh4
KSIoJTMpCQk7XG4iDQorI2RlZmluZSBQRjMoeCkJCSIJcHJlZmV0Y2hudGEg
IlBGX09GRlMoeCkiKCU0KQkJO1xuIg0KKyNkZWZpbmUgUEY0KHgpCQkiCXBy
ZWZldGNobnRhICJQRl9PRkZTKHgpIiglNSkJCTtcbiINCisjZGVmaW5lIFBG
NSh4KQkJIglwcmVmZXRjaG50YSAiUEZfT0ZGUyh4KSIoJTYpCQk7XG4iDQor
I2RlZmluZSBYTzEoeCx5KQkiICAgICAgIHhvcnBzICAgIk9GRlMoeCkiKCUy
KSwgJSV4bW0iI3kiCTtcbiINCisjZGVmaW5lIFhPMih4LHkpCSIgICAgICAg
eG9ycHMgICAiT0ZGUyh4KSIoJTMpLCAlJXhtbSIjeSIJO1xuIg0KKyNkZWZp
bmUgWE8zKHgseSkJIiAgICAgICB4b3JwcyAgICJPRkZTKHgpIiglNCksICUl
eG1tIiN5Igk7XG4iDQorI2RlZmluZSBYTzQoeCx5KQkiICAgICAgIHhvcnBz
ICAgIk9GRlMoeCkiKCU1KSwgJSV4bW0iI3kiCTtcbiINCisjZGVmaW5lIFhP
NSh4LHkpCSIgICAgICAgeG9ycHMgICAiT0ZGUyh4KSIoJTYpLCAlJXhtbSIj
eSIJO1xuIg0KIA0KIA0KIHN0YXRpYyB2b2lkDQo=
--8323328-1277751266-1000465334=:3933--
