Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312570AbSDATnl>; Mon, 1 Apr 2002 14:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312573AbSDATnc>; Mon, 1 Apr 2002 14:43:32 -0500
Received: from port-213-20-224-66.reverse.qdsl-home.de ([213.20.224.66]:14597
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S312570AbSDATnQ>; Mon, 1 Apr 2002 14:43:16 -0500
Date: Mon, 1 Apr 2002 21:43:03 +0200 (CEST)
From: Patrick McHardy <kaber@trash.net>
To: Alexey Kuznetsov <kuznet2@ms2.inr.ac.ru>
cc: linux-kernel@vger.kernel.org
Subject: bug in sch_generic.c:pfifo_fast_enqueue
Message-ID: <Pine.LNX.4.44.0204012131330.13230-200000@el-zoido.localnet>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811840-707478154-1017690183=:13230"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811840-707478154-1017690183=:13230
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Alexey.
I found a small bug in pfifo_fast_enqueue, instead of

if (list->qlen <= skb->dev->tx_queue_len)

it should be

if (list->qlen <= qdisc->dev->tx_queue_len)

i guess. the attached patch fixes it.
Bye,
Patrick


---1463811840-707478154-1017690183=:13230
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sch_generic.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0204012143030.13230@el-zoido.localnet>
Content-Description: 
Content-Disposition: attachment; filename="sch_generic.diff"

ZGlmZiAtdXJOIGxpbnV4LTIuNC4xOC1jbGVhbi9uZXQvc2NoZWQvc2NoX2dl
bmVyaWMuYyBsaW51eC0yLjQuMTgtc2NoZWRfZml4ZWQvbmV0L3NjaGVkL3Nj
aF9nZW5lcmljLmMNCi0tLSBsaW51eC0yLjQuMTgtY2xlYW4vbmV0L3NjaGVk
L3NjaF9nZW5lcmljLmMJRnJpIEF1ZyAxOCAxOToyNjoyNSAyMDAwDQorKysg
bGludXgtMi40LjE4LXNjaGVkX2ZpeGVkL25ldC9zY2hlZC9zY2hfZ2VuZXJp
Yy5jCVNhdCBNYXIgMzAgMTE6NDU6NTYgMjAwMg0KQEAgLTI4MCw3ICsyODAs
NyBAQA0KIAlsaXN0ID0gKChzdHJ1Y3Qgc2tfYnVmZl9oZWFkKilxZGlzYy0+
ZGF0YSkgKw0KIAkJcHJpbzJiYW5kW3NrYi0+cHJpb3JpdHkmVENfUFJJT19N
QVhdOw0KIA0KLQlpZiAobGlzdC0+cWxlbiA8PSBza2ItPmRldi0+dHhfcXVl
dWVfbGVuKSB7DQorCWlmIChsaXN0LT5xbGVuIDw9IHFkaXNjLT5kZXYtPnR4
X3F1ZXVlX2xlbikgew0KIAkJX19za2JfcXVldWVfdGFpbChsaXN0LCBza2Ip
Ow0KIAkJcWRpc2MtPnEucWxlbisrOw0KIAkJcmV0dXJuIDA7DQo=
---1463811840-707478154-1017690183=:13230--
