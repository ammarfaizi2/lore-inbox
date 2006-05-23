Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWEWROo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWEWROo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWEWROo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:14:44 -0400
Received: from 131.103.46-69.q9.net ([69.46.103.131]:17000 "EHLO
	exchange.gtcorp.com") by vger.kernel.org with ESMTP
	id S1750811AbWEWROo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:14:44 -0400
Subject: Compact Flash Serial ATA patch
From: Russell McConnachie <russell.mcconnachie@guest-tek.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-vk4aXg/h4hPBBBYc/mNv"
Date: Tue, 23 May 2006 04:16:37 -0600
Message-Id: <1148379397.1182.4.camel@gt-alphapbx2>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vk4aXg/h4hPBBBYc/mNv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I was having some trouble with a serial ATA compact flash adapter with
libata. I wrote a small patch for the kernel to work around the sanity
check, dma blacklisting and device ID detections in ata_dev_classify(). 

I am not exactly a programmer, I'm sure this can be written much better
but for anyone who may run into a similar problem with compact flash.

Russell McConnachie.


--=-vk4aXg/h4hPBBBYc/mNv
Content-Disposition: attachment; filename=linux-2.6.16.16-compactflash-sata.patch
Content-Type: text/x-patch; name=linux-2.6.16.16-compactflash-sata.patch; charset=us-ascii
Content-Transfer-Encoding: base64

ODIyLDgyNWM4MjIsODQ1DQo8IAkgICAgKCh0Zi0+bGJhbSA9PSAweDNjKSAmJiAodGYtPmxiYWgg
PT0gMHhjMykpKSB7DQo8IAkJRFBSSU5USygiZm91bmQgQVRBIGRldmljZSBieSBzaWdcbiIpOw0K
PCAJCXJldHVybiBBVEFfREVWX0FUQTsNCjwgCX0NCi0tLQ0KPiAJCS8vIEFsbG93cyB0aGUgY29t
cGFjdCBmbGFzaCB0byB3b3JrLCBGb3Igc29tZSByZWFzb24gb3VyIA0KPiAJCS8vIEFkZG9uaWNz
IFNBVEEgZmxhc2ggcmVhZGVyL3dyaXRlci4gDQo+IAkJLy8gVGhlIGZvbGxvd2luZyB0eXBlcyBv
ZiBmbGFzaCBoYXZlIGJlZW4gdXNlZDogDQo+IAkJLy8gCS0gSW5maW5lb24gMi4wR0INCj4gCQkv
LyAJLSBTYW5kaXNrIFVsdHJhIElJIDIuMEdCIA0KPiAJCS8vIAktIExleGFyIFBsYXRpbnVtDQo+
IAkJLy8NCj4gCQ0KPiAJCS8vIFNhbmRpc2sgQ29tcGFjdCBGbGFzaA0KPiAJCSgodGYtPmxiYW0g
PT0gMHgzMCkgJiYgKHRmLT5sYmFoID09IDApKSB8fA0KPiAJCSANCj4gCQkvLyBJbmZpbmVvbiBD
b21wYWN0IEZsYXNoIA0KPiAJCSgodGYtPmxiYW0gPT0gMHg1MCkgJiYgKHRmLT5sYmFoID09IDAp
KSB8fA0KPiAJCSANCj4gCQkvLyBJbmZpbmVvbiBDb21wYWN0IEZsYXNoIA0KPiAJCSgodGYtPmxi
YW0gPT0gMHg1NSkgJiYgKHRmLT5sYmFoID09IDApKSB8fA0KPiAJCSAgICAgICAgICAgDQo+IAkJ
Ly8gSW5maW5lb24gQ29tcGFjdCBGbGFzaCANCj4gCQkoKCh0Zi0+bGJhbSA+IDB4MmYpICYmICh0
Zi0+bGJhbSA8IDB4N2YpKSAgJiYgKHRmLT5sYmFoID09IDApKSB8fA0KPiAJCSANCj4gCQkoKHRm
LT5sYmFtID09IDB4M2MpICYmICh0Zi0+bGJhaCA9PSAweGMzKSkpIHsNCj4gCQkgICAgICAgIERQ
UklOVEsoImZvdW5kIEFUQSBkZXZpY2UgYnkgc2lnXG4iKTsNCj4gCQkgICAgICAgIHJldHVybiBB
VEFfREVWX0FUQTsNCj4gCQl9DQo4NzVhODk2LDg5Nw0KPiAJZWxzZSBpZiAoZGV2aWNlID09IDAp
DQo+IAkJLyogZG8gbm90aGluZyAqLyA7IA0KMTMzNSwxMzM2YzEzNTcsMTM1OA0KPCAJCWlmICgh
YXRhX2lkX2lzX2F0YShkZXYtPmlkKSkJLyogc2FuaXR5IGNoZWNrICovDQo8IAkJCWdvdG8gZXJy
X291dF9ub3N1cDsNCi0tLQ0KPiAvLwkJaWYgKCFhdGFfaWRfaXNfYXRhKGRldi0+aWQpKQkvKiBz
YW5pdHkgY2hlY2sgKi8NCj4gLy8JCQlnb3RvIGVycl9vdXRfbm9zdXA7DQoyMjM1YTIyNTgsMjI2
MA0KPiAJIk1PREVMIiwNCj4gCSJTTUkgTU9ERUwiLA0KPiAJIlNhbkRpc2sgU0RDRkgtMjA0OCIs
DQo=


--=-vk4aXg/h4hPBBBYc/mNv--
