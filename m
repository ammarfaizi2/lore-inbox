Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVAVANC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVAVANC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVAVALT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:11:19 -0500
Received: from fw91ext.math.uni-frankfurt.de ([141.2.42.131]:11453 "EHLO
	samson.math.uni-frankfurt.de") by vger.kernel.org with ESMTP
	id S262620AbVAVAHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:07:15 -0500
Date: Sat, 22 Jan 2005 01:07:10 +0100 (CET)
From: Bjoern Brill <brill@fs.math.uni-frankfurt.de>
X-X-Sender: brill@samson.math.uni-frankfurt.de
To: linux-kernel@vger.kernel.org
cc: Bjoern Brill <brill@fs.math.uni-frankfurt.de>
Subject: linux 2.4.28 umount oops
Message-ID: <Pine.LNX.4.58.0501220024310.3368@samson.math.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="42806107-21900878-1106351486=:3368"
Content-ID: <Pine.LNX.4.58.0501220056230.3368@samson.math.uni-frankfurt.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--42806107-21900878-1106351486=:3368
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0501220056231.3368@samson.math.uni-frankfurt.de>

Hello list,

my machine oopses in the umount script at shutdown once every few
weeks (at 1-2 shutdowns / day). Two times this resulted in repairable
errors on an EXT3 filesystem during the next bootup.

This is on an i386 (actually AMD K6-II) machine with a single IDE disk.
The mounted filesystems are EXT3 and VFAT. I don't use LVM, cryptoloop, or
other fancy stuff. The kernel is a self-compiled kernel.org 2.4.28 with no
extra patches; I think the problem did also occur with at least 2.4.27
and 2.4.26.

Attached is the output of ver_linux and ksymoops. (I had to copy the oops
by hand. I tried to be careful, but may have made errors.) More data
(dmesg, etc) can be found at
<http://fs.math.uni-frankfurt.de/~brill/oops-20050119/>
and I can produce anything else on request.

According to ksymoops, EIP points to an address in
fs/buffer.c::__remove_inode_queue(). Could somebody please have a look at
the oops or point me to the right person? (I couldn't find a suitable
entry in the MAINTAINERS file.)

Please CC me on list replies.


Thanks,

Bjoern Brill
--
Bj"orn Brill <brill@fs.math.uni-frankfurt.de>
Frankfurt am Main, Germany

--42806107-21900878-1106351486=:3368
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ver_linux.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0501220051260.3368@samson.math.uni-frankfurt.de>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ver_linux.txt"

SWYgc29tZSBmaWVsZHMgYXJlIGVtcHR5IG9yIGxvb2sgdW51c3VhbCB5b3Ug
bWF5IGhhdmUgYW4gb2xkIHZlcnNpb24uDQpDb21wYXJlIHRvIHRoZSBjdXJy
ZW50IG1pbmltYWwgcmVxdWlyZW1lbnRzIGluIERvY3VtZW50YXRpb24vQ2hh
bmdlcy4NCiANCkxpbnV4IGt2YWVmam9yZCAyLjQuMjggIzMgVHVlIE5vdiAy
MyAwMTo1MDoxNCBDRVQgMjAwNCBpNTg2IHVua25vd24NCiANCkdudSBDICAg
ICAgICAgICAgICAgICAgMi45NS40DQpHbnUgbWFrZSAgICAgICAgICAgICAg
IDMuNzkuMQ0KdXRpbC1saW51eCAgICAgICAgICAgICAyLjExbg0KbW91bnQg
ICAgICAgICAgICAgICAgICAyLjExbg0KbW9kdXRpbHMgICAgICAgICAgICAg
ICAyLjQuMjYNCmUyZnNwcm9ncyAgICAgICAgICAgICAgMS4yNw0KUFBQICAg
ICAgICAgICAgICAgICAgICAyLjQuMQ0KTGludXggQyBMaWJyYXJ5ICAgICAg
ICAyLjIuNQ0KRHluYW1pYyBsaW5rZXIgKGxkZCkgICAyLjIuNQ0KUHJvY3Bz
ICAgICAgICAgICAgICAgICAyLjAuNw0KTmV0LXRvb2xzICAgICAgICAgICAg
ICAxLjYwDQpDb25zb2xlLXRvb2xzICAgICAgICAgIDAuMi4zDQpTaC11dGls
cyAgICAgICAgICAgICAgIDIuMC4xMQ0KTW9kdWxlcyBMb2FkZWQgICAgICAg
ICByYWRlb24gbmUgODM5MCBjcmMzMiB1c2ItdWhjaSB1c2Jjb3JlIHJ0YyBl
bXUxMGsxLWdwIGpveWRldiBhbmFsb2cgc25kLWVtdTEwazEtc3ludGggc25k
LWVtdXgtc3ludGggc25kLXNlcS1taWRpLWVtdWwgc25kLXNlcS12aXJtaWRp
IHNuZC1zZXEtbWlkaS1ldmVudCBzbmQtc2VxIHNuZC1lbXUxMGsxIHNuZC1w
Y20tb3NzIHNuZC1taXhlci1vc3Mgc25kLXBjbSBzbmQtdGltZXIgc25kLWh3
ZGVwIHNuZC1wYWdlLWFsbG9jIHNuZC11dGlsLW1lbSBzbmQtYWM5Ny1jb2Rl
YyBzbmQtcmF3bWlkaSBzbmQtc2VxLWRldmljZSBzbmQgc291bmRjb3JlIGFo
YTE1MnggaWRlLXNjc2kNCg==

--42806107-21900878-1106351486=:3368
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ksymoops.out"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0501220051261.3368@samson.math.uni-frankfurt.de>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ksymoops.out"

a3N5bW9vcHMgMi40LjUgb24gaTU4NiAyLjQuMjguICBPcHRpb25zIHVzZWQN
CiAgICAgLXYgL3Vzci9zcmMvbGludXgtMi40LjI4L3ZtbGludXggKHNwZWNp
ZmllZCkNCiAgICAgLWsgMjAwNTAxMTkwMTA4MDcua3N5bXMgKHNwZWNpZmll
ZCkNCiAgICAgLWwgMjAwNTAxMTkwMTA4MDcubW9kdWxlcyAoc3BlY2lmaWVk
KQ0KICAgICAtbyAvbGliL21vZHVsZXMvMi40LjI4LyAoZGVmYXVsdCkNCiAg
ICAgLW0gL2Jvb3QvU3lzdGVtLm1hcC0yLjQuMjggKGRlZmF1bHQpDQoNCkRl
YWN0aXZhdGluZyBzd2FwLi4uZG9uZQ0KVW5tb3VudGluZyBsb2NhbCBmaWxl
c3lzdGVtcy4uLlVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZQ0KYzAxMzFhMTINCipwZGUgPSAwMDAwMDAwMA0KT29w
czogMDAwMg0KQ1BVOiAwDQpFSVA6IDAwMTA6WzxjMDEzMWExMj5dIE5vdCB0
YWludGVkDQpVc2luZyBkZWZhdWx0cyBmcm9tIGtzeW1vb3BzIC10IGVsZjMy
LWkzODYgLWEgaTM4Ng0KRUZMQUdTOiAwMDAxMDIwMg0KZWF4OiAwMDAwMDAw
YyAgIGVieDogY2NhMDZhZDggICAgIGVjeDogMDAwMDEwMDAgICAgICAgZWR4
OiBjY2EwNmE4NA0KZXNpOiBjY2EwNmE4MCAgIGVkaTogY2NhMDY4ODggICAg
IGVicDogY2YxNTdmNTQgICAgICAgZXNwOiBjZjE1N2VmNA0KZHM6IDAwMTgg
ICAgZXM6IDAwMTggICAgc3M6IDAwMTgNClN0YWNrOiAgY2NhMDZhOTggYzAx
MzFlNzMgY2NhMDZhODQgY2NhMDZhODggY2NhMDZhODAgYzAxNDI1ZWMgY2Nh
MDZhODAgY2ZkNGZjMDANCiAgICAgICAgY2YxNTdmNTQgY2YxNTdmNTQgMDAw
MDAwMDEgMDAwMWRjYzQgMDAwMDAwMDAgYzAxNDI2OWIgYzAyNjQ5MDQgY2Zk
NGZjMDANCiAgICAgICAgY2YxNTdmNTQgYzAyNjQ4ZmMgY2ZkNGZjMDAgY2Yx
NTdmNTQgY2ZkNGZjMDAgY2ZkNGZjNDggYzAyNjViYTAgYmZmZmZmMWINCkNh
bGwgVHJhY2U6IFs8YzAxMzFlNzM+XSBbPGMwMTQyNWVjPl0gWzxjMDE0MjY5
Yj5dIFs8YzAxMzUyOWQ+XSBbPGMwMTQ0MDgxPl0NCls8YzAxMzhlMGU+XSBb
PGMwMTQ0NmFkPl0gWzxjMDEwNmIyMz5dDQpDb2RlOiA4OSA0OCAwNCA4OSAw
MSBjNyA0MiA1NCAwMCAwMCAwMCAwMCBjNyA0MyAwNCAwMCAwMCAwMCAwMCBi
OA0KDQoNCj4+RUlQOyBjMDEzMWExMiA8X19yZW1vdmVfaW5vZGVfcXVldWUr
ZS8yYz4gICA8PT09PT0NCg0KPj5lYng7IGNjYTA2YWQ4IDxfZW5kK2M3MjA1
NzgvMTA1Y2VhYTA+DQo+PmVjeDsgMDAwMDEwMDAgQmVmb3JlIGZpcnN0IHN5
bWJvbA0KPj5lZHg7IGNjYTA2YTg0IDxfZW5kK2M3MjA1MjQvMTA1Y2VhYTA+
DQo+PmVzaTsgY2NhMDZhODAgPF9lbmQrYzcyMDUyMC8xMDVjZWFhMD4NCj4+
ZWRpOyBjY2EwNjg4OCA8X2VuZCtjNzIwMzI4LzEwNWNlYWEwPg0KPj5lYnA7
IGNmMTU3ZjU0IDxfZW5kK2VlNzE5ZjQvMTA1Y2VhYTA+DQo+PmVzcDsgY2Yx
NTdlZjQgPF9lbmQrZWU3MTk5NC8xMDVjZWFhMD4NCg0KVHJhY2U7IGMwMTMx
ZTczIDxpbnZhbGlkYXRlX2lub2RlX2J1ZmZlcnMrMjMvNTg+DQpUcmFjZTsg
YzAxNDI1ZWMgPGludmFsaWRhdGVfbGlzdCszYy9iOD4NClRyYWNlOyBjMDE0
MjY5YiA8aW52YWxpZGF0ZV9pbm9kZXMrMzMvNzg+DQpUcmFjZTsgYzAxMzUy
OWQgPGtpbGxfc3VwZXIrODEvZGM+DQpUcmFjZTsgYzAxNDQwODEgPF9fbW50
cHV0KzFkLzI0Pg0KVHJhY2U7IGMwMTM4ZTBlIDxwYXRoX3JlbGVhc2UrMjYv
MmM+DQpUcmFjZTsgYzAxNDQ2YWQgPHN5c191bW91bnQrNmQvNzg+DQpUcmFj
ZTsgYzAxMDZiMjMgPHN5c3RlbV9jYWxsKzMzLzQwPg0KDQpDb2RlOyAgYzAx
MzFhMTIgPF9fcmVtb3ZlX2lub2RlX3F1ZXVlK2UvMmM+DQowMDAwMDAwMCA8
X0VJUD46DQpDb2RlOyAgYzAxMzFhMTIgPF9fcmVtb3ZlX2lub2RlX3F1ZXVl
K2UvMmM+ICAgPD09PT09DQogICAwOiAgIDg5IDQ4IDA0ICAgICAgICAgICAg
ICAgICAgbW92ICAgICVlY3gsMHg0KCVlYXgpICAgPD09PT09DQpDb2RlOyAg
YzAxMzFhMTUgPF9fcmVtb3ZlX2lub2RlX3F1ZXVlKzExLzJjPg0KICAgMzog
ICA4OSAwMSAgICAgICAgICAgICAgICAgICAgIG1vdiAgICAlZWF4LCglZWN4
KQ0KQ29kZTsgIGMwMTMxYTE3IDxfX3JlbW92ZV9pbm9kZV9xdWV1ZSsxMy8y
Yz4NCiAgIDU6ICAgYzcgNDIgNTQgMDAgMDAgMDAgMDAgICAgICBtb3ZsICAg
JDB4MCwweDU0KCVlZHgpDQpDb2RlOyAgYzAxMzFhMWUgPF9fcmVtb3ZlX2lu
b2RlX3F1ZXVlKzFhLzJjPg0KICAgYzogICBjNyA0MyAwNCAwMCAwMCAwMCAw
MCAgICAgIG1vdmwgICAkMHgwLDB4NCglZWJ4KQ0KQ29kZTsgIGMwMTMxYTI1
IDxfX3JlbW92ZV9pbm9kZV9xdWV1ZSsyMS8yYz4NCiAgMTM6ICAgYjggMDAg
MDAgMDAgMDAgICAgICAgICAgICBtb3YgICAgJDB4MCwlZWF4DQoNCg==

--42806107-21900878-1106351486=:3368--
