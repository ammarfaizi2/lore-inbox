Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTL2LIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 06:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTL2LIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 06:08:16 -0500
Received: from bay2-f11.bay2.hotmail.com ([65.54.247.11]:24075 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263281AbTL2LIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 06:08:06 -0500
X-Originating-IP: [193.172.9.65]
X-Originating-Email: [aka_mr_zapper@hotmail.com]
From: "g-j v dijk" <aka_mr_zapper@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problem with SCHED_RR and kernel 2.4.18-4GB
Date: Mon, 29 Dec 2003 12:08:05 +0100
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_27c4_2487_135b"
Message-ID: <BAY2-F11yKFRJrzdDW6000379f5@hotmail.com>
X-OriginalArrivalTime: 29 Dec 2003 11:08:05.0850 (UTC) FILETIME=[08BC0BA0:01C3CDFC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_27c4_2487_135b
Content-Type: text/plain; format=flowed

Hi All,

I'm a newbie at Linux, but have been busy developing (with some other 
people) sort of a DVB zapper demo application/stack on top of Hauppauge HW 
and SUSE 8.0 kernel 2.4.18-4GB for the last 2 months.

As the stack wil eventually be ported to one (or more) dedicated HW 
platforms, we defined an OS independant API. Now, we want to be able to set 
priorities, and have sort of a realtime behaviour.

The problem is that if I implement this, and set scheduling to be SCHED_RR, 
or SCHED_FIFO, my linux machine hangs. With SCHED_OTHER, I don't have that 
(note that for testing I used to set all prios to minimum (=1)).

I already read 2 issues/threads on the internet (that's all I could find 
closely related), but they didn't gave me the solution 
(http://www.ussg.iu.edu/hypermail/linux/kernel/0206.1/0946.html and 
http://www.cs.utah.edu/~regehr/hourglass/).

I already tinckered with it for a day now :-(

I checked whether all threads have an OS call (sem_lock, or sleep etc), to 
allow scheduling and not cause starvation of other processes/threads and yes 
that is the case and in IMHO this looks fine.

The questions:
1) Is this the right mailinglist for this question? If not, please direct me 
to the correct one, and I'm sorry for the inconvenience.
2) Attached a snippet of the code I made. Am i missing something obviously?
3) Is there a problem in 2.4.18? And if so, to which kernel should I move?

Thanks a lot,

Gert-Jan van Dijk

_________________________________________________________________
Play online games with your friends with MSN Messenger 
http://messenger.msn.nl/

------=_NextPart_000_27c4_2487_135b
Content-Type: application/octet-stream; name="gosy_thread_snippet.cpp"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="gosy_thread_snippet.cpp"

I2luY2x1ZGUgPHB0aHJlYWQuaD4gLy8gaW5jbHVkZSB0aGlzIGZpcnN0DQoj
aW5jbHVkZSA8c2NoZWQuaD4NCiNpbmNsdWRlIDxlcnJuby5oPg0KI2luY2x1
ZGUgPHNpZ25hbC5oPg0KI2luY2x1ZGUgPHN5cy9yZXNvdXJjZS5oPg0KI2lu
Y2x1ZGUgPHN5cy90aW1lLmg+DQojaW5jbHVkZSA8c3lzL3dhaXQuaD4NCiNp
bmNsdWRlIDx1bmlzdGQuaD4NCiNpbmNsdWRlIDxhc3NlcnQuaD4NCiNpbmNs
dWRlICJnb3N5X3RocmVhZC5ocHAiDQojaW5jbHVkZSAiZ29zeV90aHJlYWRp
bXBsLmhwcCINCiNpbmNsdWRlICJnbG9nX2xvZ2dpbmcuaHBwIg0KI2luY2x1
ZGUgImdvc3lfY29tbW9uLmhwcCINCg0KDQovKioqKioqKioqKioqKioqKiog
Y0dvc3lUaHJlYWRJbXBsICoqKioqKioqKioqKioqKioqLw0KDQoNCmNHb3N5
VGhyZWFkSW1wbDo6Y0dvc3lUaHJlYWRJbXBsKHZvaWQpDQp7DQogICAgbVJ1
bm5pbmcgPSBmYWxzZTsNCg0KICAgIGlmICggZ2V0ZXVpZCgpICE9IDApIC8v
IHJvb3QNCiAgICB7DQogICAgICAgIGFzc2VydChmYWxzZSk7IC8vIE11c3Qg
cnVuIGFzIHJvb3QsIGVsc2Ugd2UgY2Fubm90IGNoYW5nZSBwcmlvcml0eSBv
ZiB0YXNrDQogICAgfQ0KfQ0KDQpjR29zeVRocmVhZEltcGw6On5jR29zeVRo
cmVhZEltcGwoKQ0Kew0KfQ0KDQp2b2lkICpjR29zeVRocmVhZEltcGw6OlN0
YXJ0VGhyZWFkKGNHb3N5VGhyZWFkICpwVGhyZWFkKQ0Kew0KICAgIHBUaHJl
YWQtPlN0YXJ0VGhyZWFkKCk7DQoNCiAgICByZXR1cm4gTlVMTDsNCn0NCiAg
ICAgICAgDQoNCnZvaWQgY0dvc3lUaHJlYWRJbXBsOjpTdGFydChpbnQgUHJp
b3JpdHksIGNHb3N5VGhyZWFkKiBwVGhyZWFkKQ0Kew0KICAgIGludCAgICAg
ICAgICAgICAgICAgUmV0VmFsID0gMDsNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLy8gU0NIRURfT1RIRVIgKDAgQCBzY2hlZC5oKSAtPiBS
ZWd1bGFyLCBub24tcmVhbHRpbWUNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLy8gU0NIRURfUlIgICAgKDEgQCBzY2hlZC5oKSAtPiBSb3Vu
ZCBSb2JpbiwgUmVhbHRpbWUNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLy8gU0NIRURfRklGTyAgKDIgQCBzY2hlZC5oKSAtPiBGaXJzdC1p
biBGaXJzdC1vdXQsIFJlYWx0aW1lDQojICAgZGVmaW5lICAgICAgICAgICAg
ICBQT0xJQ1kgICAoU0NIRURfRklGTykNCiAgICBpbnQgICAgICAgICAgICAg
ICAgIFBvbGljeTsNCiAgICBwdGhyZWFkX2F0dHJfdCAgICAgIEF0dHI7DQog
ICAgc3RydWN0IHNjaGVkX3BhcmFtICBTY2hlZFBhcmFtOw0KDQogICAgYXNz
ZXJ0KCBjR29zeVRocmVhZDo6R2V0TWluUHJpbygpIDw9IFByaW9yaXR5IA0K
ICAgICAgICAgICAgJiYgDQogICAgICAgICAgICBjR29zeVRocmVhZDo6R2V0
TWF4UHJpbygpID49IFByaW9yaXR5ICk7DQojaWYgKFBPTElDWSAhPSBTQ0hF
RF9PVEhFUikNCiAgICAvLyBTQ0hFRF9SUiAmIFNDSEVEX0ZJRk8gaGF2ZSBw
cmlvIGJldHdlZW4gMS4uOTksIHNvIGFkZCAxIHRvIHByaW9yaXR5IG9mIEdP
U1kNCiAgICAvLyBhcyBHT1NZIGhhcyBwcmlvIGJldHdlZW4gMC4uMTUNCiAg
ICBQcmlvcml0eSA9IDE7DQogICAgYXNzZXJ0KCBzY2hlZF9nZXRfcHJpb3Jp
dHlfbWluKFBPTElDWSkgPD0gUHJpb3JpdHkgDQogICAgICAgICAgICAmJiAN
CiAgICAgICAgICAgIHNjaGVkX2dldF9wcmlvcml0eV9tYXgoUE9MSUNZKSA+
PSBQcmlvcml0eSApOw0KI2VuZGlmDQoNCiAgICBpZiAoIW1SdW5uaW5nKQ0K
ICAgIHsNCiAgICAgICAgbVJ1bm5pbmcgICAgPSB0cnVlOw0KDQogICAgICAg
IFJldFZhbCA9IHB0aHJlYWRfYXR0cl9pbml0KCZBdHRyKTsgICAgICAgIA0K
ICAgICAgICBhc3NlcnQoIFJldFZhbCA9PSAwICk7DQoNCiAgICAgICAgLy8g
RGV0YWNoIHN0YXRlIG9mIHRocmVhZCB3aWxsIHByZXZlbnQgInpvbWJpZSBw
cm9jZXNzZXMiIGFzIG5vIG5lZWQNCiAgICAgICAgLy8gdG8gam9pbiB0aHJl
YWRzIGFmdGVyIGNhbmNlbGxhdGlvbi4NCiAgICAgICAgUmV0VmFsID0gcHRo
cmVhZF9hdHRyX3NldGRldGFjaHN0YXRlKCZBdHRyLCBQVEhSRUFEX0NSRUFU
RV9ERVRBQ0hFRCk7DQogICAgICAgIGFzc2VydCggUmV0VmFsID09IDAgKTsN
Cg0KI2lmIChQT0xJQ1kgIT0gU0NIRURfT1RIRVIpDQogICAgICAgIFJldFZh
bCA9IHB0aHJlYWRfYXR0cl9zZXRzY2hlZHBvbGljeSggJkF0dHIsIFBPTElD
WSk7DQogICAgICAgIGFzc2VydCggUmV0VmFsID09IDAgKTsNCiAgICAgICAg
U2NoZWRQYXJhbS5zY2hlZF9wcmlvcml0eSA9IFByaW9yaXR5Ow0KICAgICAg
ICBSZXRWYWwgPSBwdGhyZWFkX2F0dHJfc2V0c2NoZWRwYXJhbSggJkF0dHIs
ICZTY2hlZFBhcmFtKTsgIA0KICAgICAgICBhc3NlcnQoIFJldFZhbCA9PSAw
ICk7DQojZW5kaWYNCiAgICAgICAgUmV0VmFsID0gcHRocmVhZF9jcmVhdGUo
Jm1UaHJlYWQsICZBdHRyLCAodm9pZCAqKCopICh2b2lkICopKSZTdGFydFRo
cmVhZCwgKHZvaWQgKilwVGhyZWFkKTsNCiAgICAgICAgYXNzZXJ0KCBSZXRW
YWwgPT0gMCApOw0KDQogICAgICAgIFJldFZhbCA9IHB0aHJlYWRfZ2V0c2No
ZWRwYXJhbShtVGhyZWFkLCAmUG9saWN5LCAmU2NoZWRQYXJhbSk7DQogICAg
ICAgIGFzc2VydCggUmV0VmFsID09IDAgKTsNCiAgICAgICAgYXNzZXJ0KCBQ
b2xpY3kgPT0gUE9MSUNZICk7DQojaWYgKFBPTElDWSAhPSBTQ0hFRF9PVEhF
UikNCiAgICAgICAgYXNzZXJ0KCBTY2hlZFBhcmFtLnNjaGVkX3ByaW9yaXR5
ID09IFByaW9yaXR5ICk7DQojZW5kaWYNCg0KICAgICAgICBSZXRWYWwgPSBw
dGhyZWFkX2F0dHJfZGVzdHJveSgmQXR0cik7DQogICAgICAgIGFzc2VydCgg
UmV0VmFsID09IDAgKTsNCiAgICB9DQp9DQoNCmludCBjR29zeVRocmVhZElt
cGw6OlNldFByaW9yaXR5KGludCBQcmlvcml0eSkNCnsNCiAgICBzdHJ1Y3Qg
c2NoZWRfcGFyYW0gIFNjaGVkUGFyYW07DQogICAgaW50ICAgICAgICAgICAg
ICAgICBSZXRWYWwgPSAwOw0KICAgIHB0aHJlYWRfYXR0cl90ICAgICAgQXR0
cjsNCg0KICAgIGlmIChQcmlvcml0eSA8IGNHb3N5VGhyZWFkOjpHZXRNaW5Q
cmlvKCkNCiAgICAgICAgfHwNCiAgICAgICAgUHJpb3JpdHkgPiBjR29zeVRo
cmVhZDo6R2V0TWF4UHJpbygpKQ0KICAgIHsNCiAgICAgICAgcmV0dXJuIEdP
U1lfV1JPTkdfUFJJTzsNCiAgICB9DQoNCiNpZiAoUE9MSUNZICE9IFNDSEVE
X09USEVSKQ0KICAgIGFzc2VydChtUnVubmluZyk7DQoNCiAgICBSZXRWYWwg
PSBwdGhyZWFkX2F0dHJfaW5pdCgmQXR0cik7ICAgICAgICANCiAgICBhc3Nl
cnQoIFJldFZhbCA9PSAwICk7DQoNCiAgICBTY2hlZFBhcmFtLnNjaGVkX3By
aW9yaXR5ID0gUHJpb3JpdHk7DQogICAgUmV0VmFsID0gcHRocmVhZF9zZXRz
Y2hlZHBhcmFtKG1UaHJlYWQsIFBPTElDWSwgJlNjaGVkUGFyYW0pOw0KICAg
IGFzc2VydCggUmV0VmFsID09IDAgKTsNCiNlbmRpZg0KfQ0KDQoNCg==


------=_NextPart_000_27c4_2487_135b--
