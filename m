Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753291AbWKDF1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbWKDF1i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 00:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753595AbWKDF1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 00:27:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:42284 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1753291AbWKDF1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 00:27:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:x-google-sender-auth;
        b=rq5lThfiHLacBsJGGpspyyif9sBDoZs+Bs2MTkFxPC54Ln3Mpql7yKvYZToF2AWhvig142jVW+tixl2d0XGRlLMqOaNo27N9Y7tgRs6a28kIm4qjt3XoyWSA5rnbtHuBlLNjgfgRg0WC4wEz1YzalzlOofKqx+p9uv9YKgIPCYQ=
Message-ID: <86802c440611032127u33442a33ufc4cf3b11e9b8c7a@mail.gmail.com>
Date: Fri, 3 Nov 2006 21:27:35 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Greg KH" <gregkh@suse.de>, "Andi Kleen" <ak@suse.de>,
       "Andrew Morton" <akpm@osdl.org>
Subject: [Patch] PCI: check szhi when sz is 0 for 64 bit pref mem
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_32765_18175093.1162618055166"
X-Google-Sender-Auth: cc609eda6427792b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_32765_18175093.1162618055166
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please check the patch.

------=_Part_32765_18175093.1162618055166
Content-Type: text/x-patch; name=pci_64bit_pref_4g.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eu3kno8j
Content-Disposition: attachment; filename="pci_64bit_pref_4g.patch"

W1BhdGNoXSBQQ0k6IGNoZWNrIHN6aGkgd2hlbiBzeiBpcyAwIGZvciA2NCBiaXQgcHJlZiBtZW0K
CglGb3IgY28tcHJjZXNzb3Igd2l0aCBtZW0gaW5zdGFsbGVkLCB0aGUgcmFtIHdpbGwgYmUgdHJl
YXRlZCB0byBwcmVmIG1lbS4JCglVbmRlciA2NGJpdCBrZXJuZWwsIHdoZW4gNjRiaXQgcHJlZiBt
ZW0gc2l6ZSBpcyBhYm92ZSA0Rywgc3ogZnJvbSBwY2lfc2l6ZSBpbiBsb3cgYml0cywgd2lsbCBn
ZXQgMCwgCglhdCB0aGlzIHBvaW50LCB3ZSBuZWVkIHRvIGNoZWNrIHN6aGkgdG9vLiBPdGhlcndp
c2UgdGhlIHByZS1zZXQgdmFsdWUgYnkgZmlybXdhcmUgY2FuIG5vdCBiZSByZWFkIAoJdG8gcmVz
cm91cmNlIHN0cnVjdCwgaXQgd2lsbCBza2lwIHRoYXQgcmVzb3VyY2UsIGFuZCB0cnkgdG8gaGkg
MzIgYml0IGFzIGFub3RoZXIgMzJiaXQgcmVzb3VyY2UuCgoJQ2M6IE15bGVzIFdhdHNvbiA8bXls
ZXNAbW91c2VsZW11ci5jcy5ieXUuZWR1PgoJU2lnbmVkLW9mZi1ieTogWWluZ2hhaSBMdSA8eWlu
Z2hhaS5sdUBhbWQuY29tPgkKCgotLS0gYS9kcml2ZXJzL3BjaS9wcm9iZS5jCisrKyBiL2RyaXZl
cnMvcGNpL3Byb2JlLmMKQEAgLTE2NSw4ICsxNjUsMTMgQEAgc3RhdGljIHZvaWQgcGNpX3JlYWRf
YmFzZXMoc3RydWN0IHBjaV9kZQogCQkJbCA9IDA7CiAJCWlmICgobCAmIFBDSV9CQVNFX0FERFJF
U1NfU1BBQ0UpID09IFBDSV9CQVNFX0FERFJFU1NfU1BBQ0VfTUVNT1JZKSB7CiAJCQlzeiA9IHBj
aV9zaXplKGwsIHN6LCAodTMyKVBDSV9CQVNFX0FERFJFU1NfTUVNX01BU0spOwotCQkJaWYgKCFz
eikKLQkJCQljb250aW51ZTsKKwkJCS8qIGZvciA2NGJpdCBwcmVmLCBzeiBjb3VsZCBiZSAwLCBp
ZiB0aGUgcmVhbCBzaXplIGlzIGJpZ2dlciB0aGFuIDRHLAorCQkJCXNvIG5lZWQgdG8gY2hlY2sg
c3poaSBmb3IgaXQKKwkJCSAqLworCQkJaWYgKChsICYgKFBDSV9CQVNFX0FERFJFU1NfU1BBQ0Ug
fCBQQ0lfQkFTRV9BRERSRVNTX01FTV9UWVBFX01BU0spKQorCQkJICAgICE9IChQQ0lfQkFTRV9B
RERSRVNTX1NQQUNFX01FTU9SWSB8IFBDSV9CQVNFX0FERFJFU1NfTUVNX1RZUEVfNjQpKSAKKwkJ
CQlpZiAoIXN6KQorCQkJCQljb250aW51ZTsKIAkJCXJlcy0+c3RhcnQgPSBsICYgUENJX0JBU0Vf
QUREUkVTU19NRU1fTUFTSzsKIAkJCXJlcy0+ZmxhZ3MgfD0gbCAmIH5QQ0lfQkFTRV9BRERSRVNT
X01FTV9NQVNLOwogCQl9IGVsc2UgewpAQCAtMTg4LDYgKzE5MywxMiBAQCBzdGF0aWMgdm9pZCBw
Y2lfcmVhZF9iYXNlcyhzdHJ1Y3QgcGNpX2RlCiAJCQlzemhpID0gcGNpX3NpemUobGhpLCBzemhp
LCAweGZmZmZmZmZmKTsKIAkJCW5leHQrKzsKICNpZiBCSVRTX1BFUl9MT05HID09IDY0CisJCQlp
ZiggIXN6ICYmICFzemhpKSB7CisJCQkJcmVzLT5zdGFydCA9IDA7CisJCQkJcmVzLT5lbmQgPSAw
OworCQkJCXJlcy0+ZmxhZ3MgPSAwOworCQkJCWNvbnRpbnVlOworCQkJfQogCQkJcmVzLT5zdGFy
dCB8PSAoKHVuc2lnbmVkIGxvbmcpIGxoaSkgPDwgMzI7CiAJCQlyZXMtPmVuZCA9IHJlcy0+c3Rh
cnQgKyBzejsKIAkJCWlmIChzemhpKSB7Cg==
------=_Part_32765_18175093.1162618055166--
