Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319092AbSH2Fa2>; Thu, 29 Aug 2002 01:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319095AbSH2Fa2>; Thu, 29 Aug 2002 01:30:28 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:50307 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S319092AbSH2Fa1>; Thu, 29 Aug 2002 01:30:27 -0400
Date: Thu, 29 Aug 2002 01:34:43 -0400 (EDT)
From: Albert Cranford <ac9410@attbi.com>
X-X-Sender: ac9410@home1
Reply-To: Albert Cranford <ac9410@attbi.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch 1/5] 2.4.20-pre5 i2c updates
Message-ID: <Pine.LNX.4.44.0208290120310.16793-200000@home1>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-2079334743-1030599283=:16793"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-2079334743-1030599283=:16793
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello Marcelo,
Attached are i2c patches that bring the kernel to the latest released and tested
version.  Updates include:
o Support for SMBus 2.0 PEC Packet Error Checking
o New algorithm-i2c-algo-8xxx for MPC8XXX
o New algorithm-i2c-algo-ibm_ocp for IBM PPC 405
o New adapter-i2c-adap-ibm_ocp for IBM PPC 405
o New adapter-i2c-frodo for SA 1110 board
o New adapter-i2c-pcf-epp for PCF8584
o New adapter-i2c-pport for parallel port
o New adapter-i2c-rpx for embeded MPC8XX
o Updated documentation
Thanks,
Albert
-- 
ac9410@attbi.com

--0-2079334743-1030599283=:16793
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=47-i2c-1-patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0208290134430.16793@home1>
Content-Description: 
Content-Disposition: attachment; filename=47-i2c-1-patch

LS0tIGxpbnV4L2RyaXZlcnMvaTJjL0NvbmZpZy5pbi5vcmlnCTIwMDItMDct
MjMgMDE6NDc6MTQuMDAwMDAwMDAwIC0wNDAwDQorKysgbGludXgvZHJpdmVy
cy9pMmMvQ29uZmlnLmluCTIwMDItMDctMjMgMDE6NDc6MTQuMDAwMDAwMDAw
IC0wNDAwDQpAQCAtMzIsMTAgKzMyLDEwIEBADQogICAgICAgICAgZGVwX3Ry
aXN0YXRlICcgIEVtYmVkZGVkIFBsYW5ldCBSUFggTGl0ZS9DbGFzc2ljIHN1
cHBvb3J0JyBDT05GSUdfSTJDX1JQWExJVEUgJENPTkZJR19JMkNfQUxHTzhY
WA0KICAgICAgIGZpDQogICAgZmkNCi0gICBpZiBbICIkQ09ORklHXzQwNSIg
PSAieSIgXTsgdGhlbg0KLSAgICAgIGRlcF90cmlzdGF0ZSAnUFBDIDQwNSBJ
MkMgQWxnb3JpdGhtJyBDT05GSUdfSTJDX1BQQzQwNV9BTEdPICRDT05GSUdf
STJDDQotICAgICAgaWYgWyAiJENPTkZJR19JMkNfUFBDNDA1X0FMR08iICE9
ICJuIiBdOyB0aGVuDQotICAgICAgICAgZGVwX3RyaXN0YXRlICcgIFBQQyA0
MDUgSTJDIEFkYXB0ZXInIENPTkZJR19JMkNfUFBDNDA1X0FEQVAgJENPTkZJ
R19JMkNfUFBDNDA1X0FMR08NCisgICBpZiBbICIkQ09ORklHX0lCTV9PQ1Ai
ID0gInkiIF07IHRoZW4NCisgICAgICBkZXBfdHJpc3RhdGUgJ0lCTSBvbi1j
aGlwIEkyQyBBbGdvcml0aG0nIENPTkZJR19JMkNfSUJNX09DUF9BTEdPICRD
T05GSUdfSTJDDQorICAgICAgaWYgWyAiJENPTkZJR19JMkNfSUJNX09DUF9B
TEdPIiAhPSAibiIgXTsgdGhlbg0KKyAgICAgICAgIGRlcF90cmlzdGF0ZSAn
ICBJQk0gb24tY2hpcCBJMkMgQWRhcHRlcicgQ09ORklHX0kyQ19JQk1fT0NQ
X0FEQVAgJENPTkZJR19JMkNfSUJNX09DUF9BTEdPDQogICAgICAgZmkNCiAg
ICBmaQ0KIA0KQEAgLTQ3LDcgKzQ3LDcgQEANCiAjIFRoaXMgaXMgbmVlZGVk
IGZvciBhdXRvbWF0aWMgcGF0Y2ggZ2VuZXJhdGlvbjogc2Vuc29ycyBjb2Rl
IGVuZHMgaGVyZQ0KIA0KICAgIGRlcF90cmlzdGF0ZSAnSTJDIGRldmljZSBp
bnRlcmZhY2UnIENPTkZJR19JMkNfQ0hBUkRFViAkQ09ORklHX0kyQw0KLSAg
IGRlcF90cmlzdGF0ZSAnSTJDIC9wcm9jIGludGVyZmFjZSAocmVxdWlyZWQg
Zm9yIGhhcmR3YXJlIHNlbnNvcnMpJyBDT05GSUdfSTJDX1BST0MgJENPTkZJ
R19JMkMNCisgICBkZXBfdHJpc3RhdGUgJ0kyQyAvcHJvYyBpbnRlcmZhY2Ug
KHJlcXVpcmVkIGZvciBoYXJkd2FyZSBzZW5zb3JzKScgQ09ORklHX0kyQ19Q
Uk9DICRDT05GSUdfSTJDICRDT05GSUdfU1lTQ1RMDQogDQogZmkNCiBlbmRt
ZW51DQo=
--0-2079334743-1030599283=:16793--
