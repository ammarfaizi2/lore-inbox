Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264664AbRFPVKt>; Sat, 16 Jun 2001 17:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264662AbRFPVKj>; Sat, 16 Jun 2001 17:10:39 -0400
Received: from kaiser.cip.physik.uni-muenchen.de ([141.84.136.1]:37636 "EHLO
	kaiser.cip.physik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S264658AbRFPVKf>; Sat, 16 Jun 2001 17:10:35 -0400
Date: Sat, 16 Jun 2001 23:09:56 +0200 (CEST)
From: "Andreas K. Huettel" <Andreas.Huettel@Physik.Uni-Muenchen.DE>
Reply-To: "Andreas K. Huettel" <andreas@akhuettel.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac14: machine responds to _every fifth_ ping!
Message-ID: <Pine.LNX.4.21.0106162241540.27001-200000@ankogel.cip.physik.uni-muenchen.de>
X-Information: My public GPG key can be obtained at http://www.akhuettel.de/
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1418532232-1534896657-992725712=:27001"
Content-ID: <Pine.LNX.4.21.0106162309310.27001@ankogel.cip.physik.uni-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1418532232-1534896657-992725712=:27001
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0106162309311.27001@ankogel.cip.physik.uni-muenchen.de>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dear all, 

I am using a box with 2.4.5-ac14, 3c59x eth0 driver, 3c905C network card.
When working with it, the network has been behaving ok. Now I ping it from
a remote location, and I see the following strange effect:

After a few seconds, only every fifth ping gets back! (quite
exactly, reproducible). Ping output attached.

Another box on the same hub responds totally normal, so it is no network
congestion. I cannot ssh in at the moment, unfortunately. I tried several
different ping source machines, running 2.2.14(SuSE71), 2.2.14 SMP
(vanilla+int.crypto), 2.2.19, and a SPARCstation - they all give basically
the same result.

(Well, besides the target machine is one of these still constantly logging
"clock timer configuration lost - probably a VIA686a motherboard".)

lspci:
00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1647
(rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4)
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
00:06.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV]
00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 74)
00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev a1) 

I hope this helps fixing some bug. 

best regards, Andreas

- ---------------------------------------------------------------------
Andreas K. Huettel          andreas@akhuettel.de
81627 Muenchen              huettel@qubit.org
Germany                     http://www.akhuettel.de/
- ---------------------------------------------------------------------  
Please use GNUPG or PGP for signed and encrypted email. My public key 
can be found at http://www.akhuettel.de/pgp_key.html
- ---------------------------------------------------------------------  

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7K8spL+gLs3iH94cRAisYAKCBS4t4zpO3Pro6fUPirHnJzWF84QCeI/ok
QSZa20+XBuESVEf+KqHEvlA=
=AkrB
-----END PGP SIGNATURE-----


--1418532232-1534896657-992725712=:27001
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=strange-ping
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0106162308320.27001@ankogel.cip.physik.uni-muenchen.de>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=strange-ping

aHVldHRlbEBjZW50cmFsc2VydmljZXM6fi9EaXBsb21UYWxrID4gcGluZyBx
dWJpdA0KUElORyBxdWJpdC5zb21lLWRvbWFpbiAoeC55LjE0Mi42KTogNTYg
ZGF0YSBieXRlcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2Vx
PTAgdHRsPTI1NSB0aW1lPTAuNTg3IG1zDQo2NCBieXRlcyBmcm9tIHgueS4x
NDIuNjogaWNtcF9zZXE9MSB0dGw9MjU1IHRpbWU9MC41NDUgbXMNCjY0IGJ5
dGVzIGZyb20geC55LjE0Mi42OiBpY21wX3NlcT0yIHR0bD0yNTUgdGltZT0w
LjU1MSBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTMg
dHRsPTI1NSB0aW1lPTAuNTQ0IG1zDQo2NCBieXRlcyBmcm9tIHgueS4xNDIu
NjogaWNtcF9zZXE9NCB0dGw9MjU1IHRpbWU9MC41NDUgbXMNCjY0IGJ5dGVz
IGZyb20geC55LjE0Mi42OiBpY21wX3NlcT05IHR0bD0yNTUgdGltZT0wLjU0
NyBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTE0IHR0
bD0yNTUgdGltZT0wLjU0NCBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6
IGljbXBfc2VxPTE5IHR0bD0yNTUgdGltZT0wLjU1MyBtcw0KNjQgYnl0ZXMg
ZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTI0IHR0bD0yNTUgdGltZT0wLjUz
OCBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTI5IHR0
bD0yNTUgdGltZT0wLjUyOCBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6
IGljbXBfc2VxPTM0IHR0bD0yNTUgdGltZT0wLjU0NSBtcw0KNjQgYnl0ZXMg
ZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTM5IHR0bD0yNTUgdGltZT0wLjU0
NSBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTQ0IHR0
bD0yNTUgdGltZT0wLjU0MiBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6
IGljbXBfc2VxPTQ5IHR0bD0yNTUgdGltZT0wLjUyMiBtcw0KNjQgYnl0ZXMg
ZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTU0IHR0bD0yNTUgdGltZT0wLjUx
OSBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTU5IHR0
bD0yNTUgdGltZT0wLjUzNSBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6
IGljbXBfc2VxPTY0IHR0bD0yNTUgdGltZT0wLjU0MCBtcw0KLS0tIHF1Yml0
LnNvbWUtZG9tYWluIHBpbmcgc3RhdGlzdGljcyAtLS0NCjY1IHBhY2tldHMg
dHJhbnNtaXR0ZWQsIDE3IHBhY2tldHMgcmVjZWl2ZWQsIDczJSBwYWNrZXQg
bG9zcw0Kcm91bmQtdHJpcCBtaW4vYXZnL21heCA9IDAuNTE5LzAuNTQyLzAu
NTg3IG1zDQoNCmh1ZXR0ZWxAY2VudHJhbHNlcnZpY2VzOn4vRGlwbG9tVGFs
ayA+IHBpbmcgcXViaXQNClBJTkcgcXViaXQuc29tZS1kb21haW4gKHgueS4x
NDIuNik6IDU2IGRhdGEgYnl0ZXMNCjY0IGJ5dGVzIGZyb20geC55LjE0Mi42
OiBpY21wX3NlcT0wIHR0bD0yNTUgdGltZT0wLjYwNyBtcw0KNjQgYnl0ZXMg
ZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTEgdHRsPTI1NSB0aW1lPTAuNTQ1
IG1zDQo2NCBieXRlcyBmcm9tIHgueS4xNDIuNjogaWNtcF9zZXE9MiB0dGw9
MjU1IHRpbWU9MC41NDAgbXMNCjY0IGJ5dGVzIGZyb20geC55LjE0Mi42OiBp
Y21wX3NlcT0zIHR0bD0yNTUgdGltZT0wLjUzNyBtcw0KNjQgYnl0ZXMgZnJv
bSB4LnkuMTQyLjY6IGljbXBfc2VxPTQgdHRsPTI1NSB0aW1lPTAuNTM5IG1z
DQo2NCBieXRlcyBmcm9tIHgueS4xNDIuNjogaWNtcF9zZXE9NSB0dGw9MjU1
IHRpbWU9MC41MzcgbXMNCjY0IGJ5dGVzIGZyb20geC55LjE0Mi42OiBpY21w
X3NlcT02IHR0bD0yNTUgdGltZT0wLjUzOCBtcw0KNjQgYnl0ZXMgZnJvbSB4
LnkuMTQyLjY6IGljbXBfc2VxPTExIHR0bD0yNTUgdGltZT0wLjU0MyBtcw0K
NjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTE2IHR0bD0yNTUg
dGltZT0wLjU1MCBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBf
c2VxPTIxIHR0bD0yNTUgdGltZT0wLjUxOCBtcw0KNjQgYnl0ZXMgZnJvbSB4
LnkuMTQyLjY6IGljbXBfc2VxPTI2IHR0bD0yNTUgdGltZT0wLjYwOSBtcw0K
NjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTMxIHR0bD0yNTUg
dGltZT0wLjU0MyBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBf
c2VxPTM2IHR0bD0yNTUgdGltZT0wLjU0NSBtcw0KNjQgYnl0ZXMgZnJvbSB4
LnkuMTQyLjY6IGljbXBfc2VxPTQxIHR0bD0yNTUgdGltZT0wLjU1MSBtcw0K
NjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTQ2IHR0bD0yNTUg
dGltZT0wLjU0MyBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBf
c2VxPTUxIHR0bD0yNTUgdGltZT0wLjUzNyBtcw0KLS0tIHF1Yml0LnNvbWUt
ZG9tYWluIHBpbmcgc3RhdGlzdGljcyAtLS0NCjUyIHBhY2tldHMgdHJhbnNt
aXR0ZWQsIDE2IHBhY2tldHMgcmVjZWl2ZWQsIDY5JSBwYWNrZXQgbG9zcw0K
cm91bmQtdHJpcCBtaW4vYXZnL21heCA9IDAuNTE4LzAuNTQ4LzAuNjA5IG1z
DQoNCmh1ZXR0ZWxAY2VudHJhbHNlcnZpY2VzOn4vRGlwbG9tVGFsayA+IHBp
bmcgcXViaXQNClBJTkcgcXViaXQuc29tZS1kb21haW4gKHgueS4xNDIuNik6
IDU2IGRhdGEgYnl0ZXMNCjY0IGJ5dGVzIGZyb20geC55LjE0Mi42OiBpY21w
X3NlcT0wIHR0bD0yNTUgdGltZT0wLjU5OCBtcw0KNjQgYnl0ZXMgZnJvbSB4
LnkuMTQyLjY6IGljbXBfc2VxPTEgdHRsPTI1NSB0aW1lPTAuNTUwIG1zDQo2
NCBieXRlcyBmcm9tIHgueS4xNDIuNjogaWNtcF9zZXE9MiB0dGw9MjU1IHRp
bWU9MC41NTAgbXMNCjY0IGJ5dGVzIGZyb20geC55LjE0Mi42OiBpY21wX3Nl
cT0zIHR0bD0yNTUgdGltZT0wLjU0NSBtcw0KNjQgYnl0ZXMgZnJvbSB4Lnku
MTQyLjY6IGljbXBfc2VxPTQgdHRsPTI1NSB0aW1lPTAuNTQ3IG1zDQo2NCBi
eXRlcyBmcm9tIHgueS4xNDIuNjogaWNtcF9zZXE9NSB0dGw9MjU1IHRpbWU9
MC41MjAgbXMNCjY0IGJ5dGVzIGZyb20geC55LjE0Mi42OiBpY21wX3NlcT02
IHR0bD0yNTUgdGltZT0wLjU0MyBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQy
LjY6IGljbXBfc2VxPTEwIHR0bD0yNTUgdGltZT0wLjYxMCBtcw0KNjQgYnl0
ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTE1IHR0bD0yNTUgdGltZT0w
LjU0OSBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTIw
IHR0bD0yNTUgdGltZT0wLjU0NSBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQy
LjY6IGljbXBfc2VxPTI1IHR0bD0yNTUgdGltZT0wLjU0NCBtcw0KNjQgYnl0
ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTMwIHR0bD0yNTUgdGltZT0w
LjU1NCBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTM1
IHR0bD0yNTUgdGltZT0wLjU0MiBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQy
LjY6IGljbXBfc2VxPTQwIHR0bD0yNTUgdGltZT0wLjU1NCBtcw0KNjQgYnl0
ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTQ2IHR0bD0yNTUgdGltZT0w
LjU0OCBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTUx
IHR0bD0yNTUgdGltZT0wLjUxNSBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQy
LjY6IGljbXBfc2VxPTU2IHR0bD0yNTUgdGltZT0wLjU0NyBtcw0KNjQgYnl0
ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTYxIHR0bD0yNTUgdGltZT0w
LjU1MSBtcw0KLS0tIHF1Yml0LnNvbWUtZG9tYWluIHBpbmcgc3RhdGlzdGlj
cyAtLS0NCjYzIHBhY2tldHMgdHJhbnNtaXR0ZWQsIDE4IHBhY2tldHMgcmVj
ZWl2ZWQsIDcxJSBwYWNrZXQgbG9zcw0Kcm91bmQtdHJpcCBtaW4vYXZnL21h
eCA9IDAuNTE1LzAuNTUwLzAuNjEwIG1zDQoNCmh1ZXR0ZWxAY2VudHJhbHNl
cnZpY2VzOn4vRGlwbG9tVGFsayA+IHBpbmcgcXViaXQNClBJTkcgcXViaXQu
c29tZS1kb21haW4gKHgueS4xNDIuNik6IDU2IGRhdGEgYnl0ZXMNCjY0IGJ5
dGVzIGZyb20geC55LjE0Mi42OiBpY21wX3NlcT0wIHR0bD0yNTUgdGltZT0w
LjU5NSBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTEg
dHRsPTI1NSB0aW1lPTAuNTUzIG1zDQo2NCBieXRlcyBmcm9tIHgueS4xNDIu
NjogaWNtcF9zZXE9MiB0dGw9MjU1IHRpbWU9MC41NTYgbXMNCjY0IGJ5dGVz
IGZyb20geC55LjE0Mi42OiBpY21wX3NlcT0zIHR0bD0yNTUgdGltZT0wLjU1
NSBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTQgdHRs
PTI1NSB0aW1lPTAuNTQ5IG1zDQo2NCBieXRlcyBmcm9tIHgueS4xNDIuNjog
aWNtcF9zZXE9NSB0dGw9MjU1IHRpbWU9MC41MjAgbXMNCjY0IGJ5dGVzIGZy
b20geC55LjE0Mi42OiBpY21wX3NlcT02IHR0bD0yNTUgdGltZT0wLjU0OSBt
cw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTEwIHR0bD0y
NTUgdGltZT0wLjUzMyBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGlj
bXBfc2VxPTE1IHR0bD0yNTUgdGltZT0wLjUzOCBtcw0KNjQgYnl0ZXMgZnJv
bSB4LnkuMTQyLjY6IGljbXBfc2VxPTIwIHR0bD0yNTUgdGltZT0wLjU2NiBt
cw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTI1IHR0bD0y
NTUgdGltZT0wLjU0OCBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGlj
bXBfc2VxPTMwIHR0bD0yNTUgdGltZT0wLjU1MCBtcw0KNjQgYnl0ZXMgZnJv
bSB4LnkuMTQyLjY6IGljbXBfc2VxPTM1IHR0bD0yNTUgdGltZT0wLjU0NyBt
cw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTQxIHR0bD0y
NTUgdGltZT0wLjUzNCBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGlj
bXBfc2VxPTQ2IHR0bD0yNTUgdGltZT0wLjUyOSBtcw0KNjQgYnl0ZXMgZnJv
bSB4LnkuMTQyLjY6IGljbXBfc2VxPTUxIHR0bD0yNTUgdGltZT0wLjU1NiBt
cw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTU2IHR0bD0y
NTUgdGltZT0wLjUyNSBtcw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGlj
bXBfc2VxPTYxIHR0bD0yNTUgdGltZT0wLjYwOSBtcw0KNjQgYnl0ZXMgZnJv
bSB4LnkuMTQyLjY6IGljbXBfc2VxPTY2IHR0bD0yNTUgdGltZT0wLjU0NSBt
cw0KNjQgYnl0ZXMgZnJvbSB4LnkuMTQyLjY6IGljbXBfc2VxPTcxIHR0bD0y
NTUgdGltZT0wLjU0MiBtcw0KLS0tIHF1Yml0LnNvbWUtZG9tYWluIHBpbmcg
c3RhdGlzdGljcyAtLS0NCjczIHBhY2tldHMgdHJhbnNtaXR0ZWQsIDIwIHBh
Y2tldHMgcmVjZWl2ZWQsIDcyJSBwYWNrZXQgbG9zcw0Kcm91bmQtdHJpcCBt
aW4vYXZnL21heCA9IDAuNTIwLzAuNTQ5LzAuNjA5IG1zDQpodWV0dGVsQGNl
bnRyYWxzZXJ2aWNlczp+L0RpcGxvbVRhbGsgPg0K
--1418532232-1534896657-992725712=:27001--
