Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313258AbSD3LrM>; Tue, 30 Apr 2002 07:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313260AbSD3LrL>; Tue, 30 Apr 2002 07:47:11 -0400
Received: from suhkur.cc.ioc.ee ([193.40.251.100]:58335 "HELO suhkur.cc.ioc.ee")
	by vger.kernel.org with SMTP id <S313258AbSD3LrJ>;
	Tue, 30 Apr 2002 07:47:09 -0400
Date: Tue, 30 Apr 2002 14:47:07 +0300 (EET DST)
From: Juhan Ernits <juhan@cc.ioc.ee>
To: linux-kernel@vger.kernel.org
Subject: Admtek Comet (SMC1255TX) wierd errors on Alpha 
Message-ID: <Pine.GSO.4.21.0204301435510.9588-200000@suhkur.cc.ioc.ee>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-824023566-1020167227=:9588"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-824023566-1020167227=:9588
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hello,

the problem looks like this:


PING www.ee (212.107.32.146): 56 data bytes
64 bytes from 212.107.32.146: icmp_seq=0 ttl=249 time=3.7 ms
wrong data byte #34 should be 0x22 but was 0x28
        14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 28 4 75 0 22 23 24 21 22
23 24 25 22 23 24 25 22 23 
        24 25 ff ff 0 0 0 0 0 0 0 0 0 0 0 0 
64 bytes from 212.107.32.146: icmp_seq=1 ttl=249 time=3.7 ms
wrong data byte #34 should be 0x22 but was 0x0
        14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 0 0 0 5 22 23 24 25 22
23 24 25 22 23 24 25 0 6 
        7 74 0 6 0 0 0 0 0 0 0 0 0 0 0 0 
64 bytes from 212.107.32.146: icmp_seq=2 ttl=249 time=3.2 ms
wrong data byte #34 should be 0x22 but was 0xff
        14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 ff ff ff ff 22 23 24 25
22 23 24 25 22 23 24 25 22 23 
        24 25 ff 5 0 0 0 0 0 0 0 0 0 0 0 0 
64 bytes from 212.107.32.146: icmp_seq=3 ttl=249 time=2.5 ms
wrong data byte #34 should be 0x22 but was 0x0
        14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 0 0 0 0 22 23 24 21 22
23 24 25 22 23 24 25 22 23 
        24 25 0 0 0 0 0 0 0 0 0 0 0 0 0 0 

--- www.ee ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 2.5/3.2/3.7 ms



the card is SMC1255TX which features an Accton EN5251B chip. It works fine
in x86 boxes with PCI 2.0 and PCI 2.1 (have not tried with 2.2 but should
work according to documentation). My tests were done with on x86 and alpha
with linux 2.4.18 kernel and with single and multiple cards of the same
and different types. The distribution is Debian unstable/woody.

I have a Ruffian Alpha box (which has PCI bus version 2.0, due to which I
could not use the currently sold 3com cards, which require pci 2.1). So,
having tested the SMC1255TX card on x86 boxes I tried to use them on the
Alpha box, but got the above error messages (the box appears dumb from
across the net).

Does the problem seem to be a hardware compatibility issue of SMC1255TX or
does it have anything to do with the Alpha port of the kernel?

I tried both the kernel version of the tulip  driver and the unmodified
version of Donald Becker's pci-scan and tulip modules, but the result was
similar.

The worrying line in tulip-diag output (attached) is the following:

Interrupt sources are pending!  CSR5 is fc06c812.

(note that the other tulip 21142/43 works fine with both versions of the
tulip module)

What could one do about it?


Juhan Ernits




P.S. I posted this also to tulip-bug@scyld.com.

---559023410-824023566-1020167227=:9588
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="error.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.21.0204301447070.9588@suhkur.cc.ioc.ee>
Content-Description: 
Content-Disposition: attachment; filename="error.txt"

UElORyB3d3cuZWUgKDIxMi4xMDcuMzIuMTQ2KTogNTYgZGF0YSBieXRlcw0K
NjQgYnl0ZXMgZnJvbSAyMTIuMTA3LjMyLjE0NjogaWNtcF9zZXE9MCB0dGw9
MjQ5IHRpbWU9My4xIG1zDQp3cm9uZyBkYXRhIGJ5dGUgIzM0IHNob3VsZCBi
ZSAweDIyIGJ1dCB3YXMgMHg0DQoJMTQgMTUgMTYgMTcgMTggMTkgMWEgMWIg
MWMgMWQgMWUgMWYgMjAgMjEgNCAxIDQzIGMwIDIyIDIzIDI0IDI1IDIyIDIz
IDI0IDI1IDIyIDIzIDI0IDI1IDIyIDIzIA0KCTI0IDI1IDJkIGMwIDAgMCAw
IDAgMCAwIDAgMCAwIDAgMCAwIA0KNjQgYnl0ZXMgZnJvbSAyMTIuMTA3LjMy
LjE0NjogaWNtcF9zZXE9MSB0dGw9MjQ5IHRpbWU9NC4yIG1zDQp3cm9uZyBk
YXRhIGJ5dGUgIzM0IHNob3VsZCBiZSAweDIyIGJ1dCB3YXMgMHgyDQoJMTQg
MTUgMTYgMTcgMTggMTkgMWEgMWIgMWMgMWQgMWUgMWYgMjAgMjEgMiBhMyAw
IDAgMjIgMjMgMjQgMjEgMjIgMjMgMjQgMjUgMjIgMjMgMjQgMjUgMjIgMjMg
DQoJMjQgMjUgNCBjMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCANCg0KLS0t
IHd3dy5lZSBwaW5nIHN0YXRpc3RpY3MgLS0tDQoyIHBhY2tldHMgdHJhbnNt
aXR0ZWQsIDIgcGFja2V0cyByZWNlaXZlZCwgMCUgcGFja2V0IGxvc3MNCnJv
dW5kLXRyaXAgbWluL2F2Zy9tYXggPSAzLjEvMy42LzQuMiBtcw0KTW9kdWxl
ICAgICAgICAgICAgICAgICAgU2l6ZSAgVXNlZCBieSAgICBUYWludGVkOiBQ
ICANCnR1bGlwICAgICAgICAgICAgICAgICAgNDU0NDAgICAxIA0KcGNpLXNj
YW4gICAgICAgICAgICAgICAgNDU4NCAgIDEgIFt0dWxpcF0NCjNjNTl4ICAg
ICAgICAgICAgICAgICAgMzU4NjQgICAwIA0KMDA6MGQuMCBQQ0kgYnJpZGdl
OiBEaWdpdGFsIEVxdWlwbWVudCBDb3Jwb3JhdGlvbiBERUNjaGlwIDIxMDUy
IChyZXYgMDIpDQowMDowZS4wIElTQSBicmlkZ2U6IEludGVsIENvcnAuIDgy
MzcxU0IgUElJWDMgSVNBIFtOYXRvbWEvVHJpdG9uIElJXSAocmV2IDAxKQ0K
MDA6MGUuMSBJREUgaW50ZXJmYWNlOiBJbnRlbCBDb3JwLiA4MjM3MVNCIFBJ
SVgzIElERSBbTmF0b21hL1RyaXRvbiBJSV0NCjAwOjBmLjAgRXRoZXJuZXQg
Y29udHJvbGxlcjogRGlnaXRhbCBFcXVpcG1lbnQgQ29ycG9yYXRpb24gREVD
Y2hpcCAyMTE0Mi80MyAocmV2IDMwKQ0KMDE6MDkuMCBFdGhlcm5ldCBjb250
cm9sbGVyOiAzQ29tIENvcnBvcmF0aW9uIDNjOTA1Qy1UWCBbRmFzdCBFdGhl
cmxpbmtdIChyZXYgNzgpDQowMTowYS4wIEV0aGVybmV0IGNvbnRyb2xsZXI6
IEFjY3RvbiBUZWNobm9sb2d5IENvcnBvcmF0aW9uIEVOLTEyMTYgRXRoZXJu
ZXQgQWRhcHRlciAocmV2IDExKQ0KMDE6MGMuMCBWR0EgY29tcGF0aWJsZSBj
b250cm9sbGVyOiBTMyBJbmMuIDg2Yzk4OCBbVmlSR0UvVlhdIChyZXYgMDIp
DQowMTowZC4wIFNDU0kgc3RvcmFnZSBjb250cm9sbGVyOiBMU0kgTG9naWMg
LyBTeW1iaW9zIExvZ2ljIChmb3JtZXJseSBOQ1IpIDUzYzg3NSAocmV2IDAz
KQ0KDQp0dWxpcC1kaWFnLmM6djIuMDggNS8xNS8yMDAxIERvbmFsZCBCZWNr
ZXIgKGJlY2tlckBzY3lsZC5jb20pDQogaHR0cDovL3d3dy5zY3lsZC5jb20v
ZGlhZy9pbmRleC5odG1sDQpJbmRleCAjMTogRm91bmQgYSBEaWdpdGFsIERT
MjExNDMgVHVsaXAgYWRhcHRlciBhdCAweDgwMDAuDQpEaWdpdGFsIERTMjEx
NDMgVHVsaXAgY2hpcCByZWdpc3RlcnMgYXQgMHg4MDAwOg0KIDB4MDA6IGZm
YTBlMDAwIGZmZmZmZmZmIGZmZmZmZmZmIDg3YmRhMDAwIDg3YmRhMjAwIGYw
NjYwMDAwIGIzODYyMDAyIGZiZmZmYmZmDQogMHg0MDogZTAwMDAwMDAgZmZm
NTgzZmYgZmZmZmZmZmYgZmZmZTAwMDAgMDAwMDAxYzQgZmZmZjAwMDEgZmZm
YmZmN2YgOGZmMDAwMDgNCiBQb3J0IHNlbGVjdGlvbiBpcyAxMDBtYnBzLVNZ
TS9QQ1MgMTAwYmFzZVR4IHNjcmFtYmxlciwgaGFsZi1kdXBsZXguDQogVHJh
bnNtaXQgc3RhcnRlZCwgUmVjZWl2ZSBzdGFydGVkLCBoYWxmLWR1cGxleC4N
CiAgVGhlIFJ4IHByb2Nlc3Mgc3RhdGUgaXMgJ1dhaXRpbmcgZm9yIHBhY2tl
dHMnLg0KICBUaGUgVHggcHJvY2VzcyBzdGF0ZSBpcyAnSWRsZScuDQogIFRo
ZSB0cmFuc21pdCB0aHJlc2hvbGQgaXMgMTI4Lg0KICBUaGUgTldheSBzdGF0
dXMgcmVnaXN0ZXIgaXMgMDAwMDAxYzQuDQpFRVBST00gNjQgd29yZHMsIDYg
YWRkcmVzcyBiaXRzLg0KUENJIFN1YnN5c3RlbSBJRHMsIHZlbmRvciAwMDAw
LCBkZXZpY2UgMDAwMC4NCkNhcmRCdXMgSW5mb3JtYXRpb24gU3RydWN0dXJl
IGF0IG9mZnNldCAwMDAwMDAwMC4NCkV0aGVybmV0IE1BQyBTdGF0aW9uIEFk
ZHJlc3MgMDA6MDA6RjA6NTE6MDE6NDkuDQpFRVBST00gdHJhbnNjZWl2ZXIv
bWVkaWEgZGVzY3JpcHRpb24gdGFibGUuDQpMZWFmIG5vZGUgYXQgb2Zmc2V0
IDMwLCBkZWZhdWx0IG1lZGlhIHR5cGUgMDgwMCAoQXV0b3NlbnNlKS4NCiA0
IHRyYW5zY2VpdmVyIGRlc2NyaXB0aW9uIGJsb2NrczoNCiAgTWVkaWEgMTBi
YXNlVCwgYmxvY2sgdHlwZSAyLCBsZW5ndGggNi4NCiAgIFNlcmlhbCB0cmFu
c2NlaXZlciBmb3IgMTBiYXNlVCAobWVkaWEgdHlwZSAwKS4NCiAgICBHUCBw
aW4gZGlyZWN0aW9uIDA4YWYgIEdQIHBpbiBkYXRhIDAwYTUuDQogIE1lZGlh
IDEwYmFzZVQtRnVsbCBEdXBsZXgsIGJsb2NrIHR5cGUgMiwgbGVuZ3RoIDYu
DQogICBTZXJpYWwgdHJhbnNjZWl2ZXIgZm9yIDEwYmFzZVQtRnVsbCBEdXBs
ZXggKG1lZGlhIHR5cGUgNCkuDQogICAgR1AgcGluIGRpcmVjdGlvbiAwOGFm
ICBHUCBwaW4gZGF0YSAwMGE1Lg0KICBNZWRpYSAxMDBiYXNlVHgsIGJsb2Nr
IHR5cGUgNCwgbGVuZ3RoIDguDQogICBTWU0gdHJhbnNjZWl2ZXIgZm9yIDEw
MGJhc2VUeCAobWVkaWEgdHlwZSAzKS4NCiAgICBHUCBwaW4gZGlyZWN0aW9u
IDA4YWYgIEdQIHBpbiBkYXRhIDAwYTUuDQogICAgTm8gbWVkaWEgZGV0ZWN0
aW9uIGluZGljYXRpb24gKGNvbW1hbmQgODAgNjEpLg0KICBNZWRpYSAxMDBi
YXNlVHggRnVsbCBEdXBsZXgsIGJsb2NrIHR5cGUgNCwgbGVuZ3RoIDguDQog
ICBTWU0gdHJhbnNjZWl2ZXIgZm9yIDEwMGJhc2VUeCBGdWxsIER1cGxleCAo
bWVkaWEgdHlwZSA1KS4NCiAgICBHUCBwaW4gZGlyZWN0aW9uIDA4YWYgIEdQ
IHBpbiBkYXRhIDAwYTUuDQogICAgTm8gbWVkaWEgZGV0ZWN0aW9uIGluZGlj
YXRpb24gKGNvbW1hbmQgODAgNjEpLg0KICAgTm8gTUlJIHRyYW5zY2VpdmVy
cyBmb3VuZCENCiAgSW50ZXJuYWwgYXV0b25lZ290aWF0aW9uIHN0YXRlIGlz
ICdBdXRvbmVnb3RpYXRpb24gZGlzYWJsZWQnLg0KSW5kZXggIzI6IEZvdW5k
IGEgQWNjdG9uIEVOMTIxNy9FTjIyNDIgKEFETXRlayBDb21ldCkgYWRhcHRl
ciBhdCAweDkwMDAuDQpBY2N0b24gRU4xMjE3L0VOMjI0MiAoQURNdGVrIENv
bWV0KSBjaGlwIHJlZ2lzdGVycyBhdCAweDkwMDA6DQogMHgwMDogZmZmOWUw
MDAgZmZmZmZmZmYgZmZmZmZmZmYgODdiZGIwMDAgODdiZGIyMDAgZmMwNmM4
MTIgZmY5NzAxMTEgZmZmZTU0MTANCiAweDQwOiBmZmZlMDAwMCBmZmY1OTdm
OCAwMDAwMDAwMCBmZmZlMDAwMCAwMDAwMDAwMCAwMDAwMDIwMCAwMDAwMDAw
MCAwMDAwMDAwOA0KIEV4dGVuZGVkIHJlZ2lzdGVyczoNCiA4MDogMjAwNmM4
MTIgMDNmZTU0MTAgYTBkYzAwMDUgMDAwMGZmMDAgMDAwMDAwMDAgODdiZGIy
NjAgODdiZGIxZDAgZmZlMGYwMDANCiBhMDogZjAwMDAwMDAgMjNlMjA0MDAg
ZmZmZjZiOTkgMDAwMDAwMDAgNDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDANCiBjMDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCiBl
MDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDAgMDAwMDAwMDAgZjAwMDAwMjcNCiBDb21ldCBkdXBsZXgg
aXMgcmVwb3J0ZWQgaW4gdGhlIE1JSSBzdGF0dXMgcmVnaXN0ZXJzLg0KIFRy
YW5zbWl0IHN0b3BwZWQsIFJlY2VpdmUgc3RvcHBlZCwgaGFsZi1kdXBsZXgu
DQogIFRoZSBSeCBwcm9jZXNzIHN0YXRlIGlzICdXYWl0aW5nIGZvciBwYWNr
ZXRzJy4NCiAgVGhlIFR4IHByb2Nlc3Mgc3RhdGUgaXMgJ1N0b3BwZWQnLg0K
ICBUaGUgdHJhbnNtaXQgdGhyZXNob2xkIGlzIDEyOC4NCiBJbnRlcnJ1cHQg
c291cmNlcyBhcmUgcGVuZGluZyEgIENTUjUgaXMgZmMwNmM4MTIuDQogICBU
eCBjb21wbGV0ZSBpbmRpY2F0aW9uLg0KICAgTGluayBwYXNzZWQgaW5kaWNh
dGlvbi4NCiAgIFRpbWVyIGV4cGlyZWQgaW5kaWNhdGlvbi4NCiAgIEVhcmx5
IFJ4IGluZGljYXRpb24uDQogIENvbWV0IE1BQyBhZGRyZXNzIHJlZ2lzdGVy
cyAyM2UyMDQwMCBmZmZmNmI5OQ0KICBDb21ldCBtdWx0aWNhc3QgZmlsdGVy
IDAwMDAwMDAwNDAwMDAwMDAuDQpFRVBST00gNjQgd29yZHMsIDYgYWRkcmVz
cyBiaXRzLg0KICBFdGhlcm5ldCBNQUMgU3RhdGlvbiBBZGRyZXNzIDAwOjA0
OmUyOjIzOjk5OjZiLg0KICBEZWZhdWx0IGNvbm5lY3Rpb24gdHlwZSAnQXV0
b3NlbnNlJy4NCiAgUENJIElEcyBWZW5kb3IgMTExMyBEZXZpY2UgMTIxNiAg
U3Vic3lzdGVtIDEwYjggMTI1NQ0KICBQQ0kgbWluX2dyYW50IDI1NSBtYXhf
bGF0ZW5jeSAyNTUuDQogIENTUjE4IHBvd2VyLXVwIHNldHRpbmcgMHhhMGRj
KioqKi4NCiBNSUkgUEhZIGZvdW5kIGF0IGFkZHJlc3MgMSwgc3RhdHVzIDB4
Nzg2OS4NCiBNSUkgUEhZIGZvdW5kIGF0IGFkZHJlc3MgMiwgc3RhdHVzIDB4
Nzg2ZC4NCiBNSUkgUEhZIGZvdW5kIGF0IGFkZHJlc3MgMywgc3RhdHVzIDB4
Nzg2ZC4NCiBNSUkgUEhZIGZvdW5kIGF0IGFkZHJlc3MgNCwgc3RhdHVzIDB4
Nzg2ZC4NCg==
---559023410-824023566-1020167227=:9588--
