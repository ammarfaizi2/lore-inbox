Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTDUVd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTDUVd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:33:26 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:17114 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262569AbTDUVdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:33:17 -0400
Date: Mon, 21 Apr 2003 17:45:19 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
In-Reply-To: <20030421232348.A30621@lst.de>
Message-ID: <Pine.LNX.4.55.0304211732580.3093@marabou.research.att.com>
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com>
 <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de>
 <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com>
 <20030421210020.A29421@lst.de> <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com>
 <20030421215637.A30019@lst.de> <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com>
 <20030421225704.A30489@lst.de> <Pine.LNX.4.55.0304211709560.2913@marabou.research.att.com>
 <20030421232348.A30621@lst.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1252756759-1050961328=:3093"
Content-ID: <Pine.LNX.4.55.0304211743500.3287@marabou.research.att.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1252756759-1050961328=:3093
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.55.0304211743501.3287@marabou.research.att.com>

On Mon, 21 Apr 2003, Christoph Hellwig wrote:

> And you are sure you have the following line in pty.c:
>
> 	pts_driver[i].flags |= TTY_DRIVER_NO_DEVFS;

Yes, it's in drivers/char/pty.c, line 458.

The complete diff between the clean source and my current tree is
attached.

I have forced another rebuild, but the problem with disappearing /dev/pts
persists.

-- 
Regards,
Pavel Roskin
--8323328-1252756759-1050961328=:3093
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="complete.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.55.0304211742080.3093@marabou.research.att.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="complete.diff"

LS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9jaGFyL3B0eS5jDQorKysgbGludXgv
ZHJpdmVycy9jaGFyL3B0eS5jDQpAQCAtNDQ4LDE3ICs0NDgsMTQgQEAgaW50
IF9faW5pdCBwdHlfaW5pdCh2b2lkKQ0KIAkJCWluaXRfd2FpdHF1ZXVlX2hl
YWQoJnB0bV9zdGF0ZVtpXVtqXS5vcGVuX3dhaXQpOw0KIAkJDQogCQlwdHNf
ZHJpdmVyW2ldID0gcHR5X3NsYXZlX2RyaXZlcjsNCi0jaWZkZWYgQ09ORklH
X0RFVkZTX0ZTDQotCQlwdHNfZHJpdmVyW2ldLm5hbWUgPSAicHRzLyVkIjsN
Ci0jZWxzZQ0KIAkJcHRzX2RyaXZlcltpXS5uYW1lID0gInB0cyI7DQotI2Vu
ZGlmDQogCQlwdHNfZHJpdmVyW2ldLnByb2NfZW50cnkgPSAwOw0KIAkJcHRz
X2RyaXZlcltpXS5tYWpvciA9IFVOSVg5OF9QVFlfU0xBVkVfTUFKT1IraTsN
CiAJCXB0c19kcml2ZXJbaV0ubWlub3Jfc3RhcnQgPSAwOw0KIAkJcHRzX2Ry
aXZlcltpXS5uYW1lX2Jhc2UgPSBpKk5SX1BUWVM7DQogCQlwdHNfZHJpdmVy
W2ldLm51bSA9IHB0bV9kcml2ZXJbaV0ubnVtOw0KIAkJcHRzX2RyaXZlcltp
XS5vdGhlciA9ICZwdG1fZHJpdmVyW2ldOw0KKwkJcHRzX2RyaXZlcltpXS5m
bGFncyB8PSBUVFlfRFJJVkVSX05PX0RFVkZTOw0KIAkJcHRzX2RyaXZlcltp
XS50YWJsZSA9IHB0c190YWJsZVtpXTsNCiAJCXB0c19kcml2ZXJbaV0udGVy
bWlvcyA9IHB0c190ZXJtaW9zW2ldOw0KIAkJcHRzX2RyaXZlcltpXS50ZXJt
aW9zX2xvY2tlZCA9IHB0c190ZXJtaW9zX2xvY2tlZFtpXTsNCi0tLSBsaW51
eC5vcmlnL2RyaXZlcnMvY2hhci90dHlfaW8uYw0KKysrIGxpbnV4L2RyaXZl
cnMvY2hhci90dHlfaW8uYw0KQEAgLTIxNzMsOSArMjE3Myw5IEBAIGludCB0
dHlfcmVnaXN0ZXJfZHJpdmVyKHN0cnVjdCB0dHlfZHJpdmUNCiAJDQogCWxp
c3RfYWRkKCZkcml2ZXItPnR0eV9kcml2ZXJzLCAmdHR5X2RyaXZlcnMpOw0K
IAkNCi0JaWYgKCAhKGRyaXZlci0+ZmxhZ3MgJiBUVFlfRFJJVkVSX05PX0RF
VkZTKSApIHsNCi0JCWZvcihpID0gMDsgaSA8IGRyaXZlci0+bnVtOyBpKysp
DQotCQkgICAgdHR5X3JlZ2lzdGVyX2RldmljZShkcml2ZXIsIGRyaXZlci0+
bWlub3Jfc3RhcnQgKyBpKTsNCisJaWYgKCEoZHJpdmVyLT5mbGFncyAmIFRU
WV9EUklWRVJfTk9fREVWRlMpKSB7DQorCQlmb3IgKGkgPSAwOyBpIDwgZHJp
dmVyLT5udW07IGkrKykNCisJCQl0dHlfcmVnaXN0ZXJfZGV2aWNlKGRyaXZl
ciwgZHJpdmVyLT5taW5vcl9zdGFydCArIGkpOw0KIAl9DQogCXByb2NfdHR5
X3JlZ2lzdGVyX2RyaXZlcihkcml2ZXIpOw0KIAlyZXR1cm4gZXJyb3I7DQpA
QCAtMjIxNSw3ICsyMjE1LDggQEAgaW50IHR0eV91bnJlZ2lzdGVyX2RyaXZl
cihzdHJ1Y3QgdHR5X2RyaQ0KIAkJCWRyaXZlci0+dGVybWlvc19sb2NrZWRb
aV0gPSBOVUxMOw0KIAkJCWtmcmVlKHRwKTsNCiAJCX0NCi0JCXR0eV91bnJl
Z2lzdGVyX2RldmljZShkcml2ZXIsIGRyaXZlci0+bWlub3Jfc3RhcnQgKyBp
KTsNCisJCWlmICghKGRyaXZlci0+ZmxhZ3MgJiBUVFlfRFJJVkVSX05PX0RF
VkZTKSkNCisJCQl0dHlfdW5yZWdpc3Rlcl9kZXZpY2UoZHJpdmVyLCBkcml2
ZXItPm1pbm9yX3N0YXJ0ICsgaSk7DQogCX0NCiAJcHJvY190dHlfdW5yZWdp
c3Rlcl9kcml2ZXIoZHJpdmVyKTsNCiAJcmV0dXJuIDA7DQotLS0gbGludXgu
b3JpZy9kcml2ZXJzL3BjbWNpYS9yc3JjX21nci5jDQorKysgbGludXgvZHJp
dmVycy9wY21jaWEvcnNyY19tZ3IuYw0KQEAgLTQ5OSwxNCArNDk5LDE2IEBA
IHZvaWQgdmFsaWRhdGVfbWVtKHNvY2tldF9pbmZvX3QgKnMpDQogDQogdm9p
ZCB2YWxpZGF0ZV9tZW0oc29ja2V0X2luZm9fdCAqcykNCiB7DQotICAgIHJl
c291cmNlX21hcF90ICptOw0KKyAgICByZXNvdXJjZV9tYXBfdCAqbSwgKm47
DQogICAgIHN0YXRpYyBpbnQgZG9uZSA9IDA7DQogICAgIA0KICAgICBpZiAo
cHJvYmVfbWVtICYmIGRvbmUrKyA9PSAwKSB7DQogCWRvd24oJnJzcmNfc2Vt
KTsNCi0JZm9yIChtID0gbWVtX2RiLm5leHQ7IG0gIT0gJm1lbV9kYjsgbSA9
IG0tPm5leHQpDQorCWZvciAobSA9IG1lbV9kYi5uZXh0OyBtICE9ICZtZW1f
ZGI7IG0gPSBuKSB7DQorCSAgICBuID0gbS0+bmV4dDsNCiAJICAgIGlmIChk
b19tZW1fcHJvYmUobS0+YmFzZSwgbS0+bnVtLCBzKSkNCiAJCWJyZWFrOw0K
Kwl9DQogCXVwKCZyc3JjX3NlbSk7DQogICAgIH0NCiB9DQotLS0gbGludXgu
b3JpZy9mcy9kZXZmcy9iYXNlLmMNCisrKyBsaW51eC9mcy9kZXZmcy9iYXNl
LmMNCkBAIC0xNzU3LDYgKzE3NTcsMTIgQEAgdm9pZCBkZXZmc19yZW1vdmUo
Y29uc3QgY2hhciAqZm10LCAuLi4pDQogCWlmIChuIDwgNjQgJiYgYnVmWzBd
KSB7DQogCQlkZXZmc19oYW5kbGVfdCBkZSA9IF9kZXZmc19maW5kX2VudHJ5
KE5VTEwsIGJ1ZiwgMCk7DQogDQorCQlpZiAoIWRlKSB7DQorCQkJcHJpbnRr
KEtFUk5fV0FSTklORyAiJXM6IG5vIGVudHJ5IGZvciAlcyFcbiIsDQorCQkJ
CQlfX0ZVTkNUSU9OX18sIGJ1Zik7DQorCQkJcmV0dXJuOw0KKwkJfQ0KKw0K
IAkJd3JpdGVfbG9jaygmZGUtPnBhcmVudC0+dS5kaXIubG9jayk7DQogCQlf
ZGV2ZnNfdW5yZWdpc3RlcihkZS0+cGFyZW50LCBkZSk7DQogCQlkZXZmc19w
dXQoZGUpOw0KLS0tIGxpbnV4Lm9yaWcvZnMvcGFydGl0aW9ucy9kZXZmcy5j
DQorKysgbGludXgvZnMvcGFydGl0aW9ucy9kZXZmcy5jDQpAQCAtODEsNyAr
ODEsNyBAQCB2b2lkIGRldmZzX2FkZF9wYXJ0aXRpb25lZChzdHJ1Y3QgZ2Vu
ZGlzDQogew0KIAljaGFyIGRpcm5hbWVbNjRdLCBzeW1saW5rWzE2XTsNCiAN
Ci0JaWYgKGRpc2stPmRldmZzX25hbWVbMF0gIT0gJ1wwJykNCisJaWYgKGRp
c2stPmRldmZzX25hbWVbMF0gPT0gJ1wwJykNCiAJCXNwcmludGYoZGlzay0+
ZGV2ZnNfbmFtZSwgIiVzL2Rpc2MlZCIsIGRpc2stPmRpc2tfbmFtZSwNCiAJ
CQkJZGlzay0+Zmlyc3RfbWlub3IgPj4gZGlzay0+bWlub3Jfc2hpZnQpOw0K
IA0K

--8323328-1252756759-1050961328=:3093--
