Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264232AbSIVNAT>; Sun, 22 Sep 2002 09:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264240AbSIVNAT>; Sun, 22 Sep 2002 09:00:19 -0400
Received: from c-24-118-234-119.mn.client2.attbi.com ([24.118.234.119]:640
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264232AbSIVNAS>; Sun, 22 Sep 2002 09:00:18 -0400
Date: Sun, 22 Sep 2002 08:04:11 -0500 (CDT)
From: "Scott M. Hoffman" <scott781@attbi.com>
Reply-To: scott781@attbi.com
To: linux-kernel@vger.kernel.org
Subject: 2.5.38 scheduling oops? at boot
Message-ID: <Pine.LNX.4.44.0209220749280.918-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1986937700-1032699589=:944"
Content-ID: <Pine.LNX.4.44.0209220800010.944@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1986937700-1032699589=:944
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0209220800011.944@localhost.localdomain>

Hi,
  I booted into 2.5.38 on a dual amd duron system using profile=2 on 
command line, and the system seemed a bit sluggish just to get bash to 
complete a filename in /proc.  I found the attached oops after these  
messages:
	Starting migration thread for cpu 1
	bad: Scheduling while atomic!

And after the oops came this:
	CPUs done 4294967295

The kernel was compiled with gcc 2.95.3, but under RedHat's 7.3.94 beta.

-- 
Scott M. Hoffman
scott781@attbi.com
Running Linux 2.4.18-11smp, up 0 days 0 hours 4 minutes 


--8323328-1986937700-1032699589=:944
Content-Type: TEXT/PLAIN; NAME="oops.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0209220759490.944@localhost.localdomain>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="oops.txt"

a3N5bW9vcHMgMi40LjUgb24gaTY4NiAyLjUuMzguICBPcHRpb25zIHVzZWQN
CiAgICAgLVYgKGRlZmF1bHQpDQogICAgIC1rIC9wcm9jL2tzeW1zIChkZWZh
dWx0KQ0KICAgICAtbCAvcHJvYy9tb2R1bGVzIChkZWZhdWx0KQ0KICAgICAt
byAvbGliL21vZHVsZXMvMi41LjM4LyAoZGVmYXVsdCkNCiAgICAgLW0gL2Jv
b3QvU3lzdGVtLm1hcC0yLjUuMzggKGRlZmF1bHQpDQoNCldhcm5pbmc6IFlv
dSBkaWQgbm90IHRlbGwgbWUgd2hlcmUgdG8gZmluZCBzeW1ib2wgaW5mb3Jt
YXRpb24uICBJIHdpbGwNCmFzc3VtZSB0aGF0IHRoZSBsb2cgbWF0Y2hlcyB0
aGUga2VybmVsIGFuZCBtb2R1bGVzIHRoYXQgYXJlIHJ1bm5pbmcNCnJpZ2h0
IG5vdyBhbmQgSSdsbCB1c2UgdGhlIGRlZmF1bHQgb3B0aW9ucyBhYm92ZSBm
b3Igc3ltYm9sIHJlc29sdXRpb24uDQpJZiB0aGUgY3VycmVudCBrZXJuZWwg
YW5kL29yIG1vZHVsZXMgZG8gbm90IG1hdGNoIHRoZSBsb2csIHlvdSBjYW4g
Z2V0DQptb3JlIGFjY3VyYXRlIG91dHB1dCBieSB0ZWxsaW5nIG1lIHRoZSBr
ZXJuZWwgdmVyc2lvbiBhbmQgd2hlcmUgdG8gZmluZA0KbWFwLCBtb2R1bGVz
LCBrc3ltcyBldGMuICBrc3ltb29wcyAtaCBleHBsYWlucyB0aGUgb3B0aW9u
cy4NCg0KU2VwIDIyIDA3OjM4OjIzIFNjb3R0cyBrZXJuZWw6IGMxNDI1ZjAw
IGMwMTE4NmVkIGMwMjhhZDgwIGMxNDI0MDAwIGMxNDI1ZjcwIGMxNDI1Zjc4
IDAwMDAwMDAwIDAwMDAwMDAwIA0KU2VwIDIyIDA3OjM4OjIzIFNjb3R0cyBr
ZXJuZWw6ICAgICAgICAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMCBjMTQyNDAwMCBjMTQyNWY3OCBjMDExOGQ5YyAwMDAwMDAwMCANClNl
cCAyMiAwNzozODoyMyBTY290dHMga2VybmVsOiAgICAgICAgYzE0MjQwMDAg
YzAzNWFjYzAgYzE0MjQwMDAgYzE0MjVmYTQgMDAwMDAwMDAgYzE0MjMwYzAg
YzAxMThiMzAgMDAwMDAwMDAgDQpTZXAgMjIgMDc6Mzg6MjMgU2NvdHRzIGtl
cm5lbDogQ2FsbCBUcmFjZTogWzxjMDExODZlZD5dIFs8YzAxMThkOWM+XSBb
PGMwMTE4YjMwPl0gWzxjMDExOGIzMD5dIFs8YzAxMWEyYzU+XSANClNlcCAy
MiAwNzozODoyMyBTY290dHMga2VybmVsOiAgICBbPGMwMTFhMzNlPl0gWzxj
MDExYTJmMD5dIFs8YzAxMDZmMGQ+XSANClNlcCAyMiAwNzozODoyMyBTY290
dHMga2VybmVsOiBjMTQyMWYxYyBjMDExODZlZCBjMDI4YWQ4MCBjMTQyMDAw
MCBjMTQyMWY4YyBjMTQyMWY5NCAwMDAwMDAwMCAwMDAwMDAwMCANClNlcCAy
MiAwNzozODoyMyBTY290dHMga2VybmVsOiAgICAgICAgMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgYzE0MjAwMDAgYzE0MjFmOTQgYzAx
MThkOWMgMDAwMDAwMDAgDQpTZXAgMjIgMDc6Mzg6MjMgU2NvdHRzIGtlcm5l
bDogICAgICAgIGMxNDIwMDAwIGMwMzVhY2MwIGMxNDIwMDAwIGMxNDIxZmMw
IDAwMDAwMDAwIGMxNDIzN2MwIGMwMTE4YjMwIDAwMDAwMDAwIA0KU2VwIDIy
IDA3OjM4OjIzIFNjb3R0cyBrZXJuZWw6IENhbGwgVHJhY2U6IFs8YzAxMTg2
ZWQ+XSBbPGMwMTE4ZDljPl0gWzxjMDExOGIzMD5dIFs8YzAxMThiMzA+XSBb
PGMwMTFhMmM1Pl0gDQpTZXAgMjIgMDc6Mzg6MjMgU2NvdHRzIGtlcm5lbDog
ICAgWzxjMDEyMjc0Zj5dIFs8YzAxMjI3MDA+XSBbPGMwMTA2ZjBkPl0gDQpX
YXJuaW5nIChPb3BzX3JlYWQpOiBDb2RlIGxpbmUgbm90IHNlZW4sIGR1bXBp
bmcgd2hhdCBkYXRhIGlzIGF2YWlsYWJsZQ0KDQoNClRyYWNlOyBjMDExODZl
ZCA8c2NoZWR1bGUrM2QvNDMwPg0KVHJhY2U7IGMwMTE4ZDljIDx3YWl0X2Zv
cl9jb21wbGV0aW9uKzljLzEwMD4NClRyYWNlOyBjMDExOGIzMCA8ZGVmYXVs
dF93YWtlX2Z1bmN0aW9uKzAvNDA+DQpUcmFjZTsgYzAxMThiMzAgPGRlZmF1
bHRfd2FrZV9mdW5jdGlvbiswLzQwPg0KVHJhY2U7IGMwMTFhMmM1IDxzZXRf
Y3B1c19hbGxvd2VkKzE0NS8xNzA+DQpUcmFjZTsgYzAxMWEzM2UgPG1pZ3Jh
dGlvbl90aHJlYWQrNGUvMzQwPg0KVHJhY2U7IGMwMTFhMmYwIDxtaWdyYXRp
b25fdGhyZWFkKzAvMzQwPg0KVHJhY2U7IGMwMTA2ZjBkIDxrZXJuZWxfdGhy
ZWFkX2hlbHBlcis1LzE4Pg0KVHJhY2U7IGMwMTE4NmVkIDxzY2hlZHVsZSsz
ZC80MzA+DQpUcmFjZTsgYzAxMThkOWMgPHdhaXRfZm9yX2NvbXBsZXRpb24r
OWMvMTAwPg0KVHJhY2U7IGMwMTE4YjMwIDxkZWZhdWx0X3dha2VfZnVuY3Rp
b24rMC80MD4NClRyYWNlOyBjMDExOGIzMCA8ZGVmYXVsdF93YWtlX2Z1bmN0
aW9uKzAvNDA+DQpUcmFjZTsgYzAxMWEyYzUgPHNldF9jcHVzX2FsbG93ZWQr
MTQ1LzE3MD4NClRyYWNlOyBjMDEyMjc0ZiA8a3NvZnRpcnFkKzRmL2YwPg0K
VHJhY2U7IGMwMTIyNzAwIDxrc29mdGlycWQrMC9mMD4NClRyYWNlOyBjMDEw
NmYwZCA8a2VybmVsX3RocmVhZF9oZWxwZXIrNS8xOD4NCg0KDQoyIHdhcm5p
bmdzIGlzc3VlZC4gIFJlc3VsdHMgbWF5IG5vdCBiZSByZWxpYWJsZS4NCg==
--8323328-1986937700-1032699589=:944--
